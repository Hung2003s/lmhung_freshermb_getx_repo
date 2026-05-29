import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/mixin/controller_mixins.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/soft_option_enums.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entity/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/product_use_case/product_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/category_sort_card.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';

class ProductController extends GetxController
    with
        PaginationMixin<ProductEntity>,
        OptimisticDeleteMixin<ProductEntity, int>,
        DialogButtonMixin {
  final ProductUseCase _useCase;

  ProductController(this._useCase);

  @override
  RxList<ProductEntity> get items => listProduct;

  @override
  Future<bool> deleteItemById(int id) async => _useCase.deleteProduct(id);

  @override
  int getIdFromItem(ProductEntity item) => item.id;

  final RxInt currentFilterIndex = 0.obs;
  final RxString productSearchText = ''.obs;
  final RxnInt selectedCategoryId = RxnInt();
  final TextEditingController searchController = TextEditingController();
  final Rx<SortOption> currentSort = SortOption.nameAsc.obs;
  final RxList<ProductEntity> listProduct = <ProductEntity>[].obs;
  Timer? debounce;

  @override
  void onInit() {
    super.onInit(); // PaginationMixin gắn scroll listener
    fetchFirstPage();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchFirstPage() async {
    try {
      isLoading.value = true;
      page.value = 1;
      hasMore = true;
      final result = await _useCase(
        keyword: productSearchText.value,
        categoryId: selectedCategoryId.value,
        page: page.value,
        limit: limit.value,
      );
      if (result.isEmpty) {
        listProduct.assignAll([]);
        errorMessage.value = "no_products_in_category".tr;
      } else {
        listProduct.assignAll(result);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore) return;
    try {
      isLoadingMore.value = true;
      page.value += 1;
      final result = await _useCase(
        keyword: productSearchText.value,
        categoryId: selectedCategoryId.value,
        page: page.value,
        limit: limit.value,
      );
      if (result.isEmpty) {
        page.value -= 1;
        hasMore = false;
      } else {
        listProduct.addAll(result);
        if (result.length < limit.value) hasMore = false;
      }
    } catch (e) {
      if (page.value > 1) page.value -= 1;
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore.value = false;
    }
  }

  /// Load danh sách sản phẩm với filter
  Future<void> fetchListProduct({
    int? categoryId,
    bool isLoadMore = false,
    String? keyword,
  }) {
    if (isLoadMore) return loadMore();
    selectedCategoryId.value = categoryId;
    return fetchFirstPage();
  }

  Future<void> searchProduct(String keyword) async {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      productSearchText.value = keyword;
      fetchFirstPage();
    });
  }

  void onSelectedFilter(int id) {
    selectedCategoryId.value = id;
    fetchFirstPage();
  }

  void sortProduct(SortOption sortOption) {
    switch (sortOption) {
      case SortOption.nameAsc:
        listProduct.sort((a, b) => a.name.compareTo(b.name));
      case SortOption.nameDesc:
        listProduct.sort((a, b) => b.name.compareTo(a.name));
      case SortOption.priceDesc:
        listProduct.sort((a, b) => b.price.compareTo(a.price));
      case SortOption.priceAsc:
        listProduct.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.stockDesc:
        listProduct.sort((a, b) => b.stock.compareTo(a.stock));
      case SortOption.stockAsc:
        listProduct.sort((a, b) => a.stock.compareTo(b.stock));
    }
  }

  /// Xoá sản phẩm với optimistic update
  void deleteProductAction(ProductEntity item) {
    showDeleteConfirmDialog(
      contentKey: 'delete_product_confirm',
      onConfirm: () => deleteItem(item.id),
    );
  }

  Future<void> navigateToInfo([ProductEntity? item]) async {
    final result = await Get.toNamed(Routes.productsInfo, arguments: item);
    if (result != null) fetchFirstPage();
  }

  void showCategoryBottomSheet() {
    final categoryController = Get.find<CategoryController>();
    final theme = Theme.of(Get.context!);
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.65),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSheetHandle(theme),
              _buildSheetHeader(theme),
              Divider(
                height: 1,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
              ),
              _buildCategoryList(theme, categoryController),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildSheetHandle(ThemeData theme) => Container(
    width: 40,
    height: 4,
    margin: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(2),
    ),
  );

  Widget _buildSheetHeader(ThemeData theme) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
    child: Row(
      children: [
        Expanded(
          child: Text(
            'select_category'.tr,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.close_rounded, color: theme.colorScheme.onSurface),
        ),
      ],
    ),
  );

  Widget _buildCategoryList(
    ThemeData theme,
    CategoryController categoryController,
  ) {
    return Flexible(
      child: Obx(
        () => ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: categoryController.listCategory.length + 1,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              return RepaintBoundary(
                child: CategorySortCard(
                  title: 'all'.tr,
                  isSelected: currentFilterIndex.value == 0,
                  onTap: () => _selectAllCategories(),
                ),
              );
            }
            final item = categoryController.listCategory[index - 1];
            return RepaintBoundary(
              child: CategorySortCard(
                title: item.name,
                isSelected: currentFilterIndex.value == index,
                onTap: () => _selectCategory(index: index, categoryId: item.id),
              ),
            );
          },
        ),
      ),
    );
  }

  void _selectAllCategories() {
    currentFilterIndex.value = 0;
    onSelectedFilter(0);
    Get.back();
  }

  void _selectCategory({required int index, required int categoryId}) {
    currentFilterIndex.value = index;
    onSelectedFilter(categoryId);
    Get.back();
  }

  String selectedCategoryTitle(CategoryController categoryController) {
    final i = currentFilterIndex.value;
    if (i == 0) return 'all_categories'.tr;
    final idx = i - 1;
    if (idx < 0 || idx >= categoryController.listCategory.length) {
      return 'all_categories'.tr;
    }
    return categoryController.listCategory[idx].name;
  }
}
