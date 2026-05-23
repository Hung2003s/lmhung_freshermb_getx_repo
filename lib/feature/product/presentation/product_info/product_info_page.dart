import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/base_view/base_view.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

import '../../../category/presentation/category_controller.dart';
import '../widget/input_infor.dart';
import 'product_info_controller.dart';

class ProductInfoPage extends GetView<ProductInfoController> {
  const ProductInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      final mode = controller.pageMode.value;
      final isReadOnly = mode == ProductPageMode.view;

      return BaseView(
        resizeToAvoidBottomInset: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        extendBodyBehindAppBar: false,
        buildAppBar: _buildAppBar(mode),
        buildBody: _buildFormBody(mode: mode, isReadOnly: isReadOnly),
      );
    });
  }

  AppBar _buildAppBar(ProductPageMode mode) {
    final theme = Theme.of(Get.context!);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text(
        _pageTitle(mode),
        style: TextStyle(color: theme.colorScheme.onSurface),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
        onPressed: () => Get.back(),
      ),
      actions: [
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
      ],
    );
  }

  String _pageTitle(ProductPageMode mode) {
    if (mode == ProductPageMode.create) return 'Them san pham';
    if (mode == ProductPageMode.edit) return 'Sua san pham';
    return 'Chi tiet san pham';
  }

  Widget _buildFormBody({
    required ProductPageMode mode,
    required bool isReadOnly,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
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
            if (!isReadOnly) _buildSaveButton(mode),
          ],
        ),
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
              color: isReadOnly ? theme.colorScheme.onSurface.withValues(alpha: 0.5) : ColorName.orange,
            ),
            const SizedBox(height: 8),
            Text(
              isReadOnly ? 'Anh san pham' : 'Them anh',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isReadOnly ? theme.colorScheme.onSurface.withValues(alpha: 0.5) : ColorName.orange,
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
      hint: 'Nhap ten san pham',
      title: 'Ten san pham',
      errorText: controller.hasSubmitted.value
          ? controller.nameError.value
          : null,
      onChanged: (String value) => controller.onFormChanged(),
    );
  }

  Widget _buildCategoryField() {
    final theme = Theme.of(Get.context!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh muc san pham',
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
      hint: 'VD: SP-001',
      title: 'SKU/Ma SP',
      errorText: controller.hasSubmitted.value
          ? controller.skuError.value
          : null,
      onChanged: (String value) => controller.onFormChanged(),
    );
  }

  Widget _buildPriceInput(bool isReadOnly) {
    return InputInfor(
      controller: controller.priceController,
      enable: isReadOnly,
      hint: 'Gia tien',
      title: 'Gia ban',
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      errorText: controller.hasSubmitted.value
          ? controller.priceError.value
          : null,
      onChanged: (String value) => controller.onFormChanged(),
    );
  }

  Widget _buildStockInput(bool isReadOnly) {
    return InputInfor(
      controller: controller.stockController,
      enable: isReadOnly,
      hint: 'VD: 100',
      title: 'So luong',
      keyboardType: TextInputType.number,
      errorText: controller.hasSubmitted.value
          ? controller.stockError.value
          : null,
      onChanged: (String value) => controller.onFormChanged(),
    );
  }

  Widget _buildDescriptionInput(bool isReadOnly) {
    return InputInfor(
      controller: controller.descController,
      enable: isReadOnly,
      hint: 'Mo ta san pham',
      title: 'Mo ta',
      maxLine: 5,
      onChanged: (String value) => controller.onFormChanged(),
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
          mode == ProductPageMode.create ? 'Tao san pham moi' : 'Luu thay doi',
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
          'Chon danh muc',
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