import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/selected_widget.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/dialog/dialog_x.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/input/custom_search_field.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/input/text_input_field.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/navigation_bar/profile_app_bar.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/entities/categories_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/widget/category_card.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

import '../../../core/common_widget/base_view/base_view.dart';
import '../../../gen/assets.gen.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      backgroundColor: Colors.black,
      buildAppBar: ProfileAppBar(greetingText: 'Quan ly', username: 'Danh muc'),
      buildBody: Stack(
        children: [_buildCategoryContent(), _buildFloatingAddButton()],
      ),
    );
  }

  Widget _buildCategoryContent() {
    return RefreshIndicator(
      color: ColorName.orange,
      backgroundColor: const Color(0xFF1E1E1E),
      onRefresh: () => controller.getListCategory(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            const SizedBox(height: 16),
            Expanded(child: _buildCategoryList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: CustomSearchField(hintText: 'Tim kiem danh muc')),
      ],
    );
  }

  Widget _buildCategoryList() {
    return Obx(
      () => ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.listCategory.length,
        itemBuilder: (context, index) {
          final item = controller.listCategory[index];
          final card = _buildCategoryCard(item);

          if (index == controller.listCategory.length - 1) {
            return Column(children: [card, const SizedBox(height: 60)]);
          }

          return card;
        },
      ),
    );
  }

  Widget _buildCategoryCard(CategoryEntity item) {
    return CategoryCard(
      icon: Assets.icons.technology.svg(),
      iconColor: ColorName.orange.withValues(alpha: 0.2),
      category: item,
      numberCount: 20,
      categoryStatus: 'tang truong',
      onEdit: () => editAction(item),
      onDelete: () => deleteAction(item),
    );
  }

  void deleteAction(CategoryEntity item) {
    Get.showCustomDialog(
      content: _buildDeleteDialogContent(),
      footer: _buildDeleteDialogFooter(item),
      title: '',
    );
  }

  Widget _buildDeleteDialogContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ban co chac chan muon xoa danh muc nay?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteDialogFooter(CategoryEntity item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildDialogButton(title: 'Huy', onTap: () => Get.back()),
        const SizedBox(width: 12),
        _buildDialogButton(
          title: 'Xac nhan',
          onTap: () {
            Get.back();
            controller.deleteCategory(item.id);
          },
        ),
      ],
    );
  }

  void editAction(CategoryEntity item) {
    Get.showCustomDialog(
      content: _buildCategoryNameInput(
        controller: controller.updateController,
        onChanged: (value) => controller.updateCategoryText.value = value,
      ),
      title: 'Cap nhat danh muc',
      footer: _buildDialogButton(
        title: 'Luu',
        verticalPadding: 4,
        onTap: () {
          Get.back();
          controller.updateCategory(item.id);
        },
      ),
    );
  }

  Positioned _buildFloatingAddButton() {
    return Positioned(
      bottom: 100,
      right: 20,
      child: SelectedWidget(
        onTap: addAction,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ColorName.orange,
            shape: BoxShape.circle,
            border: Border.all(color: ColorName.orange),
          ),
          child: Assets.icons.whiteAdd.svg(),
        ),
      ),
    );
  }

  void addAction() {
    Get.showCustomDialog(
      content: _buildCategoryNameInput(
        controller: controller.addController,
        onChanged: (value) => controller.addCategoryText.value = value,
      ),
      title: 'Them danh muc',
      footer: _buildDialogButton(
        title: 'Luu',
        verticalPadding: 4,
        onTap: () {
          Get.back();
          controller.addCategory();
        },
      ),
    );
  }

  Widget _buildCategoryNameInput({
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ten danh muc',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextInputFields(
          isShowClearButton: true,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          filledColor: Colors.white,
          onChanged: onChanged,
          controller: controller,
        ),
      ],
    );
  }

  Widget _buildDialogButton({
    required String title,
    required VoidCallback onTap,
    double verticalPadding = 8,
  }) {
    return SelectedWidget(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
