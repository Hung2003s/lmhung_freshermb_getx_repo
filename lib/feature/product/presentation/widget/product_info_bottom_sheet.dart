import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/localization/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entities/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/add_product_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/update_product_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_info/product_info_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/input_infor.dart';

import '../../../../core/gen/colors.gen.dart';

Future<bool?> showProductInfoBottomSheet({ProductEntity? initialProduct}) {
  // Tạo controller tạm thời, tự động dispose khi bottom sheet đóng
  final addProductUseCase = Get.find<AddProductUseCase>();
  final updateProductUseCase = Get.find<UpdateProductUseCase>();
  final controller = Get.put(
    ProductInfoController(addProductUseCase, updateProductUseCase),
    tag: 'product_info_bottom_sheet_${initialProduct?.id ?? 'new'}',
  );

  if (initialProduct != null) {
    controller.initialProduct = initialProduct;
    controller.checkPageModeAndFillData();
  }

  return Get.bottomSheet<bool>(
    _ProductInfoBottomSheetContent(controller: controller),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: true,
  ).whenComplete(() {
    // Dọn dẹp controller khi bottom sheet đóng
    Get.delete<ProductInfoController>(
      tag: 'product_info_bottom_sheet_${initialProduct?.id ?? 'new'}',
    );
  });
}

class _ProductInfoBottomSheetContent extends StatelessWidget {
  final ProductInfoController controller;

  const _ProductInfoBottomSheetContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      final mode = controller.pageMode.value;
      final isReadOnly = mode == ProductPageMode.view;
      return Container(
        decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle bar
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Header
                    _buildHeader(mode, theme),
                    Divider(
                      height: 1,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                    ),
                    // Form body
                    Flexible(
                      child: _buildFormBody(mode: mode, isReadOnly: isReadOnly),
                    ),
                    if (!isReadOnly) _buildSaveButton(mode).paddingSymmetric(horizontal: 16),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader(ProductPageMode mode, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _pageTitle(mode),
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (mode == ProductPageMode.view)
            IconButton(
              icon: const Icon(Icons.edit_rounded, color: ColorName.orange),
              onPressed: () => controller.changeToEditMode(),
            ),
          if (mode == ProductPageMode.edit)
            IconButton(
              icon: const Icon(Icons.close_rounded, color: ColorName.error),
              onPressed: () => controller.cancelEdit(),
            ),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.close_rounded, color: theme.colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  String _pageTitle(ProductPageMode mode) {
    if (mode == ProductPageMode.create) return LocaleKeys.addNewProduct.tr;
    if (mode == ProductPageMode.edit) return LocaleKeys.editProduct.tr;
    return LocaleKeys.productDetails.tr;
  }

  Widget _buildFormBody({
    required ProductPageMode mode,
    required bool isReadOnly,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImagePicker(isReadOnly),
          const SizedBox(height: 16),
          _buildNameInput(isReadOnly),
          _buildCategoryField(),
          const SizedBox(height: 16),
          _buildSkuPriceRow(isReadOnly),
          _buildStockInput(isReadOnly),
          _buildDescriptionInput(isReadOnly),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildImagePicker(bool isReadOnly) {
    final theme = Theme.of(Get.context!);
    return GestureDetector(
      onTap: isReadOnly ? null : () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.camera_alt,
              color: isReadOnly
                  ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                  : ColorName.orange,
            ),
            const SizedBox(height: 8),
            Text(
              isReadOnly ? LocaleKeys.productImage.tr : LocaleKeys.addImage.tr,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isReadOnly
                    ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                    : ColorName.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInput(bool isReadOnly) {
    return InputInfor(
      controller: controller.nameController,
      enable: isReadOnly,
      hint: LocaleKeys.enterProductName.tr,
      title: LocaleKeys.productName.tr,
      errorText: controller.hasSubmitted.value
          ? controller.nameError.value
          : null,
      onChanged: (value) => controller.onFormChanged(),
    );
  }

  Widget _buildCategoryField() {
    final theme = Theme.of(Get.context!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.productCategory.tr,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        _buildCategorySelectMenu(),
      ],
    );
  }

  Widget _buildSkuPriceRow(bool isReadOnly) {
    return Row(
      children: [
        Expanded(child: _buildSkuInput(isReadOnly)),
        const SizedBox(width: 12),
        Expanded(child: _buildPriceInput(isReadOnly)),
      ],
    );
  }

  Widget _buildSkuInput(bool isReadOnly) {
    return InputInfor(
      controller: controller.skuController,
      enable: isReadOnly,
      hint: LocaleKeys.skuExample.tr,
      title: LocaleKeys.skuCode.tr,
      errorText: controller.hasSubmitted.value
          ? controller.skuError.value
          : null,
      onChanged: (value) => controller.onFormChanged(),
    );
  }

  Widget _buildPriceInput(bool isReadOnly) {
    return InputInfor(
      controller: controller.priceController,
      enable: isReadOnly,
      hint: LocaleKeys.priceHint.tr,
      title: LocaleKeys.sellingPrice.tr,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      errorText: controller.hasSubmitted.value
          ? controller.priceError.value
          : null,
      onChanged: (value) => controller.onFormChanged(),
    );
  }

  Widget _buildStockInput(bool isReadOnly) {
    return InputInfor(
      controller: controller.stockController,
      enable: isReadOnly,
      hint: LocaleKeys.stockExample.tr,
      title: LocaleKeys.quantity.tr,
      keyboardType: TextInputType.number,
      errorText: controller.hasSubmitted.value
          ? controller.stockError.value
          : null,
      onChanged: (value) => controller.onFormChanged(),
    );
  }

  Widget _buildDescriptionInput(bool isReadOnly) {
    return InputInfor(
      controller: controller.descController,
      enable: isReadOnly,
      hint: LocaleKeys.productDescriptionHint.tr,
      title: LocaleKeys.description.tr,
      maxLine: 5,
      onChanged: (value) => controller.onFormChanged(),
    );
  }

  Widget _buildSaveButton(ProductPageMode mode) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorName.orange,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => controller.saveProduct(),
        child: Text(
          mode == ProductPageMode.create
              ? LocaleKeys.createNewProduct.tr
              : LocaleKeys.saveChanges.tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelectMenu() {
    final theme = Theme.of(Get.context!);
    final categoryController = Get.find<CategoryController>();
    return Obx(() {
      final currentId = controller.selectedCategoryId.value;
      final isIdExist = categoryController.listCategory.any(
        (element) => element.id == currentId,
      );

      return DropdownButtonFormField<int>(
        initialValue: isIdExist ? currentId : null,
        onChanged: controller.pageMode.value == ProductPageMode.view
            ? null
            : (int? newValue) => controller.onCategoryChanged(newValue),
        dropdownColor: theme.colorScheme.surface,
        icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
        hint: Text(
          LocaleKeys.selectCategory.tr,
          style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 14),
        ),
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: theme.colorScheme.onSurface),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
          errorText: controller.hasSubmitted.value
              ? controller.categoryError.value
              : null,
          errorStyle: const TextStyle(color: ColorName.error),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.orange, width: 2.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
        ),
        selectedItemBuilder: (BuildContext context) {
          return categoryController.listCategory.map((category) {
            return Text(
              category.name,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            );
          }).toList();
        },
        items: categoryController.listCategory.map((category) {
          return DropdownMenuItem<int>(
            value: category.id,
            child: Text(category.name),
          );
        }).toList(),
      );
    });
  }
}
