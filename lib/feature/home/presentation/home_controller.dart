import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/dialog/dialog_x.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';

class HomeController extends GetxController {
  final ScrollController contactScrollCtrl = ScrollController();

  /// Show a dialog to quickly add a category from the home screen
  void fastAddCategoryMethod() {
    final categoryController = Get.find<CategoryController>();
    final theme = Theme.of(Get.context!);
    Get.showCustomDialog(
      content: _buildFastAddContent(theme, categoryController),
      title: 'add_category'.tr,
      footer: _buildFastAddFooter(categoryController),
    );
  }

  Widget _buildFastAddContent(
    ThemeData theme,
    CategoryController categoryController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'category_name'.tr,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: categoryController.addController,
          decoration: InputDecoration(
            hintText: 'category_name'.tr,
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (value) {
            categoryController.addCategoryText.value = value;
          },
        ),
      ],
    );
  }

  Widget _buildFastAddFooter(CategoryController categoryController) {
    final theme = Theme.of(Get.context!);
    return GestureDetector(
      onTap: () {
        Get.back();
        categoryController.addCategory();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          'save'.tr,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
