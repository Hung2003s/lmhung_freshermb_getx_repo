import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/draggabble_button.dart';
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

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController _scrollController = ScrollController();
  final CategoryController controller = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Chỉ loadmore khi: có thể scroll, không đang loading, và còn dữ liệu
    if (!controller.hasMore || controller.isLoadingMore.value) return;
    if (_scrollController.position.maxScrollExtent <= 0) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      buildAppBar: ProfileAppBar(greetingText: 'manage'.tr, username: 'category'.tr),
      buildBody: Stack(
        children: [_buildCategoryContent(), _buildFloatingAddButton()],
      ),
    );
  }

  Widget _buildCategoryContent() {
    return RefreshIndicator(
      color: ColorName.orange,
      backgroundColor: Theme.of(Get.context!).colorScheme.surface,
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
        Expanded(child: CustomSearchField(hintText: 'search_category'.tr)),
      ],
    );
  }

  Widget _buildCategoryList() {
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
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
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),

          ),
          Obx(
            () => controller.isLoadingMore.value
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(CategoryEntity item) {
    return CategoryCard(
      icon: Assets.icons.technology.svg(),
      iconColor: ColorName.orange.withValues(alpha: 0.2),
      category: item,
      numberCount: 20,
      categoryStatus: 'growing'.tr,
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
    final theme = Theme.of(Get.context!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'delete_category_confirm'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteDialogFooter(CategoryEntity item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildDialogButton(title: 'cancel'.tr, onTap: () => Get.back()),
        const SizedBox(width: 12),
        _buildDialogButton(
          title: 'confirm'.tr,
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
      title: 'update_category'.tr,
      footer: _buildDialogButton(
        title: 'save'.tr,
        verticalPadding: 4,
        onTap: () {
          Get.back();
          controller.updateCategory(item.id);
        },
      ),
    );
  }

  Widget _buildFloatingAddButton() {
    return DraggableFloatingButton(
        initialOffset: Offset(20, 100),
        child: SelectedWidget(
          onTap: addAction,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorName.orange,
              shape: BoxShape.circle,
              border: Border.all(color: ColorName.orange),
            ),
            child: Assets.icons.whiteAdd.svg(width: 20),
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
      title: 'add_category'.tr,
      footer: _buildDialogButton(
        title: 'save'.tr,
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
    final theme = Theme.of(Get.context!);
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
        TextInputFields(
          isShowClearButton: true,
          textStyle: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
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
    final theme = Theme.of(Get.context!);
    return SelectedWidget(
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