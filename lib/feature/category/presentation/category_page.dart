import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/draggabble_button.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/selected_widget.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/input/custom_search_field.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/entities/categories_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/widget/category_card.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

import '../../../core/common_widget/base_view/base_view.dart';
import '../../../core/common_widget/navigation_bar/profile_app_bar.dart';
import '../../../gen/assets.gen.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      buildAppBar: ProfileAppBar(
        greetingText: 'manage'.tr,
        username: 'category'.tr,
      ),
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
        Expanded(
          child: CustomSearchField(
            hintText: 'search_category'.tr,
            controller: controller.searchController,
            showSortButton: false,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    return Obx(() {
      final displayList = controller.searchCategoryText.value.trim().isEmpty
          ? controller.listCategory
          : controller.filteredCategory;

      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: controller.scrollController,
              scrollDirection: Axis.vertical,
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final item = displayList[index];
                final card = _buildCategoryCard(item);

                if (index == displayList.length - 1) {
                  return Column(children: [card, const SizedBox(height: 60)]);
                }
                return card;
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          ),
          Obx(
            () => controller.searchCategoryText.value.trim().isNotEmpty
                ? const SizedBox.shrink()
                : controller.isLoadingMore.value
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );
    });
  }

  Widget _buildCategoryCard(CategoryEntity item) {
    return CategoryCard(
      icon: Assets.icons.technology.svg(),
      iconColor: ColorName.orange.withValues(alpha: 0.2),
      category: item,
      numberCount: 20,
      categoryStatus: 'growing'.tr,
      onEdit: () => controller.showEditDialog(item),
      onDelete: () => controller.showDeleteDialog(item),
    );
  }

  Widget _buildFloatingAddButton() {
    return DraggableFloatingButton(
      initialOffset: const Offset(20, 100),
      child: SelectedWidget(
        onTap: () => controller.showAddDialog(),
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
}
