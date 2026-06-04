import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/localization/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entities/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_controller.dart';

import '../../../../core/utils/app_toast.dart';
import '../../domain/params/product_params.dart';
import '../../domain/usecases/add_product_use_case.dart';
import '../../domain/usecases/update_product_use_case.dart';

enum ProductPageMode { view, edit, create }

class ProductInfoController extends GetxController {
  final AddProductUseCase _addProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;

  ProductInfoController(this._addProductUseCase, this._updateProductUseCase);

  // Nhận thực thể sản phẩm truyền sang (nếu có)
  ProductEntity? initialProduct;

  // Quản lý trạng thái hiện tại của trang
  final Rx<ProductPageMode> pageMode = ProductPageMode.create.obs;

  // Các TextEditingController phục vụ hiển thị/nhập liệu
  final nameController = TextEditingController();
  final skuController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descController = TextEditingController();
  final categoryController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxnInt selectedCategoryId = RxnInt();
  final RxBool hasSubmitted = false.obs;
  final RxnString nameError = RxnString();
  final RxnString skuError = RxnString();
  final RxnString priceError = RxnString();
  final RxnString stockError = RxnString();
  final RxnString categoryError = RxnString();

  void onFormChanged() {
    if (hasSubmitted.value) {
      validateForm();
    }
  }

  void onCategoryChanged(int? categoryId) {
    selectedCategoryId.value = categoryId;
    onFormChanged();
  }

  bool validateForm() {
    final name = nameController.text.trim();
    final sku = skuController.text.trim();
    final priceText = priceController.text.trim();
    final stockText = stockController.text.trim();
    final price = double.tryParse(priceText);
    final stock = int.tryParse(stockText);

    nameError.value = name.isEmpty ? LocaleKeys.nameRequired.tr : null;
    skuError.value = _validateSku(sku);
    priceError.value = _validatePrice(priceText, price);
    stockError.value = _validateStock(stockText, stock);
    categoryError.value = _validateCategory();

    return nameError.value == null &&
        skuError.value == null &&
        priceError.value == null &&
        stockError.value == null &&
        categoryError.value == null;
  }

  String? _validateSku(String sku) {
    if (sku.isEmpty) {
      return LocaleKeys.codeRequired.tr;
    }

    if (!Get.isRegistered<ProductController>()) {
      return null;
    }

    final normalizedSku = sku.toLowerCase();
    final isDuplicated = Get.find<ProductController>().listProduct.any(
      (product) =>
          product.code?.toLowerCase() == normalizedSku &&
          product.id != initialProduct?.id,
    );

    return isDuplicated ? LocaleKeys.codeExists.tr : null;
  }

  String? _validatePrice(String priceText, double? price) {
    if (priceText.isEmpty) {
      return LocaleKeys.priceRequired.tr;
    }
    if (price == null) {
      return LocaleKeys.priceInvalid.tr;
    }
    if (price <= 0) {
      return LocaleKeys.pricePositive.tr;
    }
    return null;
  }

  String? _validateStock(String stockText, int? stock) {
    if (stockText.isEmpty) {
      return null;
    }
    if (stock == null) {
      return LocaleKeys.stockInvalid.tr;
    }
    if (stock < 0) {
      return LocaleKeys.stockNonNegative.tr;
    }
    return null;
  }

  String? _validateCategory() {
    final categoryId = selectedCategoryId.value;
    if (categoryId == null) {
      return LocaleKeys.categoryRequired.tr;
    }

    if (!Get.isRegistered<CategoryController>()) {
      return null;
    }

    final isCategoryExists = Get.find<CategoryController>().listCategory.any(
      (category) => category.id == categoryId,
    );

    return isCategoryExists ? null : LocaleKeys.categoryInvalid.tr;
  }

  void clearValidationErrors() {
    hasSubmitted.value = false;
    nameError.value = null;
    skuError.value = null;
    priceError.value = null;
    stockError.value = null;
    categoryError.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    checkPageModeAndFillData();
  }

  /// Khởi tạo dữ liệu từ [initialProduct]. Gọi sau khi gán [initialProduct].
  void checkPageModeAndFillData() {
    if (initialProduct != null) {
      // Kiểm tra nếu là product giả được tạo để quét mã vạch (id = 0, name rỗng)
      // thì chuyển sang chế độ tạo mới với code đã được điền sẵn
      if (initialProduct!.id == 0 && initialProduct!.name.isEmpty) {
        pageMode.value = ProductPageMode.create;
        skuController.text = initialProduct!.code ?? '';
        selectedCategoryId.value = null;
        return;
      }

      // 🟢 Nếu có sản phẩm thật truyền sang: Mặc định vào chế độ XEM CHI TIẾT
      pageMode.value = ProductPageMode.view;

      // Đổ dữ liệu cũ vào các ô Input
      nameController.text = initialProduct!.name;
      skuController.text = initialProduct!.code!;
      priceController.text = initialProduct!.price.toString();
      stockController.text = initialProduct!.stock.toString();
      descController.text = initialProduct!.description ?? '';
      selectedCategoryId.value = initialProduct!.category?.id;
    } else {
      pageMode.value = ProductPageMode.create;
      selectedCategoryId.value = null;
    }
  }

  void changeToEditMode() {
    pageMode.value = ProductPageMode.edit;
  }

  void cancelEdit() {
    checkPageModeAndFillData();
    clearValidationErrors();
  }

  void saveProduct() {
    if (isLoading.value) {
      return;
    }

    hasSubmitted.value = true;
    if (!validateForm()) {
      return;
    }

    final name = nameController.text.trim();
    final code = skuController.text.trim();
    final description = descController.text.trim();
    final price = double.tryParse(priceController.text.trim()) ?? 0.0;
    final stock = int.tryParse(stockController.text.trim()) ?? 0;
    final categoryID = selectedCategoryId.value;

    final params = ProductInfoParam(
      name: name,
      code: code,
      price: price,
      description: description,
      stock: stock,
      category: categoryID,
    );
    if (pageMode.value == ProductPageMode.create) {
      addProduct(params);
    } else if (pageMode.value == ProductPageMode.edit) {
      updateProduct(params);
    }
    // Thêm logic gọi UseCase... Sau khi xong chuyển về Mode View hoặc Get.back()
  }

  @override
  void onClose() {
    // Giải phóng bộ nhớ
    nameController.dispose();
    skuController.dispose();
    priceController.dispose();
    stockController.dispose();
    descController.dispose();
    categoryController.dispose();
    super.onClose();
  }

  Future<void> addProduct(ProductInfoParam param) async {
    try {
      isLoading.value = true;
      final result = await _addProductUseCase(param);
      final productId = result.fold(
        (failure) => throw Exception(failure.message),
        (id) => id,
      );
      // Pop trước rồi mới hiện snackbar để snackbar không bị nuốt theo route
      Get.back(result: productId);
      AppToast.showSuccess(title: LocaleKeys.addSuccess.tr);
    } catch (e) {
      errorMessage.value = e.toString();
      AppToast.showError(
        title: LocaleKeys.addFailed.tr,
        message: errorMessage.value,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(ProductInfoParam params) async {
    try {
      if (initialProduct == null) {
        return;
      }

      isLoading.value = true;
      final result = await _updateProductUseCase(params, initialProduct!.id);
      final success = result.fold(
        (failure) => throw Exception(failure.message),
        (data) => data,
      );
      if (!success) {
        AppToast.showError(title: LocaleKeys.updateFailed.tr, message: '');
        return;
      }

      Get.back(result: true);
      AppToast.showSuccess(title: LocaleKeys.updateSuccess.tr);
    } catch (e) {
      errorMessage.value = e.toString();
      AppToast.showError(
        title: LocaleKeys.updateFailed.tr,
        message: errorMessage.value,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
