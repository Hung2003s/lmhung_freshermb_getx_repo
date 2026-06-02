import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/dialog/dialog_x.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/entities/categories_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';

/// Hiển thị dialog thêm category mới.
void showAddCategoryDialog(CategoryController controller) {
  final theme = Theme.of(Get.context!);
  Get.showCustomDialog(
    content: _CategoryNameInput(
      controller: controller.addController,
      onChanged: (value) => controller.addCategoryText.value = value,
      hintKey: 'category_name',
    ),
    title: 'add_category'.tr,
    footer: _DialogButton(
      theme: theme,
      title: 'save'.tr,
      verticalPadding: 4,
      onTap: () {
        Get.back();
        controller.addCategory();
      },
    ),
  );
}

/// Hiển thị dialog chỉnh sửa category.
void showEditCategoryDialog(
  CategoryController controller,
  CategoryEntity item,
) {
  final theme = Theme.of(Get.context!);
  Get.showCustomDialog(
    content: _CategoryNameInput(
      controller: controller.updateController,
      onChanged: (value) => controller.updateCategoryText.value = value,
      hintKey: 'category_name',
    ),
    title: 'update_category'.tr,
    footer: _DialogButton(
      theme: theme,
      title: 'save'.tr,
      verticalPadding: 4,
      onTap: () {
        Get.back();
        controller.updateCategory(item.id);
      },
    ),
  );
}

/// Input widget dùng chung cho add/edit dialog.
class _CategoryNameInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintKey;

  const _CategoryNameInput({
    required this.controller,
    required this.onChanged,
    required this.hintKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintKey.tr,
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}

/// Button widget dùng chung cho dialog.
class _DialogButton extends StatelessWidget {
  final ThemeData theme;
  final String title;
  final double verticalPadding;
  final VoidCallback onTap;

  const _DialogButton({
    required this.theme,
    required this.title,
    required this.onTap,
    this.verticalPadding = 8,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: verticalPadding,
        ),
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
}
