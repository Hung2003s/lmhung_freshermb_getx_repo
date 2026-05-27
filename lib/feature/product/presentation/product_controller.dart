import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/soft_option_enums.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entity/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/product_use_case/product_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';

import '../../../gen/colors.gen.dart';

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

  final Rx<SortOption> currentSort = SortOption.nameAsc.obs;

  final RxList<ProductEntity> listProduct = <ProductEntity>[].obs;
  RxInt page = 1.obs;
  RxInt limit = 20.obs;
  Timer? debounce;

  @override
  void onInit() {
    fetchListProduct(isLoadMore: false);
    super.onInit();
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
        final result = await _useCase(
          keyword: productSearchText.value,
          categoryId: categoryId,
          page: page.value,
          limit: limit.value,
        );
        if (result.isEmpty) {
          listProduct.assignAll([]);
          errorMessage.value = "Không tìm thấy sản phẩm nào của danh mục này";
        } else {
          listProduct.assignAll(result);
        }
        isLoading.value = false;
      } else {
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
    // Hủy timer cũ nếu người dùng vẫn đang gõ
    if (debounce?.isActive ?? false) debounce!.cancel();

    // Tạo timer mới, đợi 500ms sau khi ngừng gõ mới gọi API
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
        Get.snackbar(
          'Xoá thành công',
          '',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: ColorName.greenLight.withValues(alpha: 0.2),
        );
      } else {
        listProduct.insert(index, originalProduct);
        listProduct.refresh();
        Get.snackbar(
          'Xoá thất bại',
          errorMessage.value,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: ColorName.error.withValues(alpha: 0.2),
        );
      }
    } catch (e) {
      if (optimisticIndex != null && originalProduct != null) {
        listProduct.insert(optimisticIndex, originalProduct);
        listProduct.refresh();
      }
      errorMessage.value = e.toString();
      Get.snackbar(
        'Xoá thất bại',
        errorMessage.value,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: ColorName.error.withValues(alpha: 0.2),
      );
    }
  }

  Future<void> navigateToInfo(ProductEntity item) async {
    final result = await Get.toNamed(Routes.productsInfo, arguments: item);
    if (result != null) {
      fetchListProduct(isLoadMore: false);
    }
  }

  Future<void> navigateToCreate() async {
    final result = await Get.toNamed(Routes.productsInfo);
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
}
