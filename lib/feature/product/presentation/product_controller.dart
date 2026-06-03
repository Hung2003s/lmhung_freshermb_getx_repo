import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/mixin/controller_mixins.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/soft_option_enums.dart';
import 'package:lmhung_freshermb_getx_repo/core/localization/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entities/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/get_products_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/delete_product_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/category_bottom_sheet.dart';

import '../../../core/navigation/routes.dart';

class ProductController extends GetxController
    with
        PaginationMixin<ProductEntity>,
        OptimisticDeleteMixin<ProductEntity, int>,
        DialogButtonMixin {
  final GetProductsUseCase _getProductsUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  ProductController(this._getProductsUseCase, this._deleteProductUseCase);

  @override
  RxList<ProductEntity> get items => listProduct;

  @override
  Future<bool> deleteItemById(int id) async {
    final result = await _deleteProductUseCase(id);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (data) => data,
    );
  }

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
    debounce?.cancel();
    searchController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchFirstPage() async {
    try {
      isLoading.value = true;
      page.value = 1;
      hasMore = true;
      final result = await _getProductsUseCase(
        keyword: productSearchText.value,
        categoryId: selectedCategoryId.value,
        page: page.value,
        limit: limit.value,
      );
      final products = result.fold(
        (failure) => throw Exception(failure.message),
        (list) => list,
      );
      if (products.isEmpty) {
        listProduct.assignAll([]);
        errorMessage.value = LocaleKeys.noProductsInCategory.tr;
      } else {
        listProduct.assignAll(products);
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
      final result = await _getProductsUseCase(
        keyword: productSearchText.value,
        categoryId: selectedCategoryId.value,
        page: page.value,
        limit: limit.value,
      );
      final products = result.fold(
        (failure) => throw Exception(failure.message),
        (list) => list,
      );
      if (products.isEmpty) {
        page.value -= 1;
        hasMore = false;
      } else {
        listProduct.addAll(products);
        if (products.length < limit.value) hasMore = false;
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
      contentKey: LocaleKeys.deleteProductConfirm,
      onConfirm: () => deleteItem(item.id),
    );
  }

  Future<void> navigateToInfo([ProductEntity? item]) async {
    final result = await Get.toNamed(Routes.productsInfo, arguments: item);
    if (result != null) fetchFirstPage();
  }

  /// Hiển thị bottom sheet chọn category (UI tách ra widget riêng)
  void showCategoryBottomSheet() {
    showCategoryFilterBottomSheet(productController: this);
  }

  String selectedCategoryTitle(CategoryController categoryController) {
    final i = currentFilterIndex.value;
    if (i == 0) return LocaleKeys.allCategories.tr;
    final idx = i - 1;
    if (idx < 0 || idx >= categoryController.listCategory.length) {
      return LocaleKeys.allCategories.tr;
    }
    return categoryController.listCategory[idx].name;
  }
}
