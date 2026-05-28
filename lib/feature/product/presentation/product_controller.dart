import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/dialog/dialog_x.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/soft_option_enums.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entity/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/product_use_case/product_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/category_sort_card.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';
import '../../../core/utils/app_toast.dart';

class ProductController extends GetxController {
  final ProductUseCase _useCase;

  ProductController(this._useCase);

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentFilterIndex = 0.obs;

  final RxString productSearchText = ''.obs;
  final RxnInt selectedCategoryId = RxnInt();
  final TextEditingController searchController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  final Rx<SortOption> currentSort = SortOption.nameAsc.obs;

  final RxList<ProductEntity> listProduct = <ProductEntity>[].obs;
  RxInt page = 1.obs;
  RxInt limit = 20.obs;
  bool hasMore = true;
  Timer? debounce;

  @override
  void onInit() {
    fetchListProduct(isLoadMore: false);
    scrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchListProduct({
    int? categoryId,
    bool isLoadMore = false,
    String? keyword,
  }) async {
    try {
      if (!isLoadMore) {
        isLoading.value = true;
        page.value = 1;
        hasMore = true;
        final result = await _useCase(
          keyword: productSearchText.value,
          categoryId: categoryId,
          page: page.value,
          limit: limit.value,
        );
        if (result.isEmpty) {
          listProduct.assignAll([]);
          errorMessage.value = "no_products_in_category".tr;
        } else {
          listProduct.assignAll(result);
        }
        isLoading.value = false;
      } else {
        if (isLoadingMore.value || !hasMore) return;
        isLoadingMore.value = true;
        page.value += 1;
        final result = await _useCase(
          keyword: productSearchText.value,
          categoryId: categoryId,
          page: page.value,
          limit: limit.value,
        );
        if (result.isEmpty) {
          page.value -= 1;
          hasMore = false;
        } else {
          listProduct.addAll(result);
        }
        isLoadingMore.value = false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      if (isLoadMore && page.value > 1) {
        page.value -= 1;
      }
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> searchProduct(String keyword) async {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      productSearchText.value = keyword;
      fetchListProduct(isLoadMore: false);
    });
  }

  void onSelectedFilter(int id) {
    fetchListProduct(isLoadMore: false, categoryId: id);
  }

  Future<void> deleteProduct(int id) async {
    int? optimisticIndex;
    ProductEntity? originalProduct;
    try {
      final index = listProduct.indexWhere((category) => category.id == id);
      if (index == -1) {
        return;
      }
      optimisticIndex = index;
      originalProduct = listProduct[index];
      listProduct.removeAt(index);
      listProduct.refresh();
      final result = await _useCase.deleteProduct(id);
      if (result) {
        AppToast.showSuccess(title: 'delete_success'.tr);
      } else {
        listProduct.insert(index, originalProduct);
        listProduct.refresh();
        AppToast.showError(
          title: 'delete_failed'.tr,
          message: errorMessage.value,
        );
      }
    } catch (e) {
      if (optimisticIndex != null && originalProduct != null) {
        listProduct.insert(optimisticIndex, originalProduct);
        listProduct.refresh();
      }
      errorMessage.value = e.toString();
      AppToast.showError(
        title: 'delete_failed'.tr,
        message: errorMessage.value,
      );
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      fetchListProduct(isLoadMore: true);
    }
  }

  Future<void> navigateToInfo([ProductEntity? item]) async {
    final result = await Get.toNamed(Routes.productsInfo, arguments: item);
    if (result != null) {
      fetchListProduct(isLoadMore: false);
    }
  }

  void sortProduct(SortOption sortOption) {
    switch (sortOption) {
      case SortOption.nameAsc:
        listProduct.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.nameDesc:
        listProduct.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortOption.priceDesc:
        listProduct.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.priceAsc:
        listProduct.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.stockDesc:
        listProduct.sort((a, b) => b.stock.compareTo(a.stock));
        break;
      case SortOption.stockAsc:
        listProduct.sort((a, b) => a.stock.compareTo(b.stock));
        break;
    }
  }

  /// Show delete confirmation dialog
  void deleteProductAction(ProductEntity item) {
    final theme = Theme.of(Get.context!);
    Get.showCustomDialog(
      content: _buildDeleteDialogContent(theme),
      footer: _buildDeleteDialogFooter(theme, item),
      title: '',
    );
  }

  Widget _buildDeleteDialogContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'delete_product_confirm'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteDialogFooter(ThemeData theme, ProductEntity item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildDialogButton(theme, title: 'cancel'.tr, onTap: () => Get.back()),
        const SizedBox(width: 12),
        _buildDialogButton(
          theme,
          title: 'confirm'.tr,
          onTap: () {
            Get.back();
            deleteProduct(item.id);
          },
        ),
      ],
    );
  }

  Widget _buildDialogButton(
    ThemeData theme, {
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.4),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  /// Show category bottom sheet for filter selection
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
              _buildBottomSheetHandle(theme),
              _buildBottomSheetHeader(theme),
              Divider(
                height: 1,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
              ),
              _buildCategoryBottomSheetList(theme, categoryController),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBottomSheetHandle(ThemeData theme) {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildBottomSheetHeader(ThemeData theme) {
    return Padding(
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
  }

  Widget _buildCategoryBottomSheetList(
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
                  onTap: () => selectAllCategories(),
                ),
              );
            }

            final item = categoryController.listCategory[index - 1];
            return RepaintBoundary(
              child: CategorySortCard(
                title: item.name,
                isSelected: currentFilterIndex.value == index,
                onTap: () => selectCategory(index: index, categoryId: item.id),
              ),
            );
          },
        ),
      ),
    );
  }

  void selectAllCategories() {
    currentFilterIndex.value = 0;
    fetchListProduct(isLoadMore: false);
    Get.back();
  }

  void selectCategory({required int index, required int categoryId}) {
    currentFilterIndex.value = index;
    onSelectedFilter(categoryId);
    Get.back();
  }

  /// Get the display title for the currently selected category
  String selectedCategoryTitle(CategoryController categoryController) {
    final selectedIndex = currentFilterIndex.value;
    if (selectedIndex == 0) {
      return 'all_categories'.tr;
    }

    final categoryIndex = selectedIndex - 1;
    if (categoryIndex < 0 ||
        categoryIndex >= categoryController.listCategory.length) {
      return 'all_categories'.tr;
    }

    return categoryController.listCategory[categoryIndex].name;
  }
}
