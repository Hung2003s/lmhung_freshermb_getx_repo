import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/animation/gradient_border_animation.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/selected_widget.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/input/custom_search_field.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/soft_option_enums.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entity/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/category_sort_card.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/product_card.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

import '../../../core/common_widget/base_view/base_view.dart';
import '../../../core/common_widget/dialog/dialog_x.dart';
import '../../../gen/assets.gen.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseView(
      backgroundColor: theme.scaffoldBackgroundColor,
      buildBody: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: RefreshIndicator(
          onRefresh: () async {
            controller.fetchListProduct(isLoadMore: false);
          },
          child: Column(
            children: [
              _buildHeaderSection(),
              Expanded(child: _buildProductList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(children: [_buildTitleRow(), _buildCategoryFilter()]),
    );
  }

  Widget _buildTitleRow() {
    final theme = Theme.of(Get.context!);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'products'.tr,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        _buildAddProductButton(),
      ],
    );
  }

  Widget _buildAddProductButton() {
    return SelectedWidget(
      borderRadius: BorderRadius.circular(12),
      rippleColor: Colors.grey.withValues(alpha: 0.4),
      highlightColor: Colors.grey.withValues(alpha: 0.4),
      onTap: () => controller.navigateToCreate(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorName.orange,
        ),
        child: Assets.icons.whiteAdd.svg(),
      ),
    );
  }

  Widget _buildProductList() {
    return Obx(() {
      if (controller.listProduct.isEmpty) {
        return _buildEmptyState();
      }

      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: controller.scrollController,
              scrollDirection: Axis.vertical,
              itemCount: controller.listProduct.length,
              itemBuilder: (BuildContext context, int index) {
                final item = controller.listProduct[index];
                final isLastItem = index == controller.listProduct.length - 1;
                final card = _buildProductCard(item);
                if (isLastItem) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 60),
                    child: card,
                  );
                }

                return card;
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 8,);
              },
            ),
          ),
          Obx(
            () => controller.isLoadingMore.value
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(color: ColorName.orange),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );
    });
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(Get.context!);
    return Center(
      child: Text(
        controller.errorMessage.value,
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductEntity item) {
    return ProductCard(
      icon: Assets.icons.whiteFolder.svg(width: 16),
      iconColor: ColorName.blueLight,
      productEntity: item,
      categoryStatus: 'in_stock'.tr,
      onTap: () => controller.navigateToInfo(item),
      onDelete: () => deleteProductAction(item),
    );
  }

  void deleteProductAction(ProductEntity item) {
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
          'delete_product_confirm'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteDialogFooter(ProductEntity item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildDialogButton(title: 'cancel'.tr, onTap: () => Get.back()),
        const SizedBox(width: 12),
        _buildDialogButton(
          title: 'confirm'.tr,
          onTap: () {
            Get.back();
            controller.deleteProduct(item.id);
          },
        ),
      ],
    );
  }

  Widget _buildDialogButton({
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(Get.context!);
    return SelectedWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

  Widget _buildCategoryFilter() {
    final theme = Theme.of(Get.context!);
    final categoryController = Get.find<CategoryController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        GradientBorderAnimation(child: _buildSearchField()),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildCategoryPicker(categoryController)),
            const SizedBox(width: 16),
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                  ),
                ),
                child: PopupMenuButton<SortOption>(
                  tooltip: 'sort_filter'.tr,
                  color: theme.colorScheme.surface,
                  onSelected: (SortOption result) {
                    controller.currentSort.value = result;
                    controller.sortProduct(result);
                  },
                  itemBuilder: (BuildContext context) => SortOption.values.map((
                    option,
                  ) {
                    final isSelected = controller.currentSort.value == option;
                    return PopupMenuItem<SortOption>(
                      value: option,
                      child: Text(
                        option.title,
                        style: TextStyle(
                          color: isSelected
                              ? ColorName.orange
                              : theme.colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sort,
                          size: 20,
                          color: theme.colorScheme.onSurface,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          controller.currentSort.value.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: theme.colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildListMetaRow(),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSearchField() {
    return CustomSearchField(
      focusColor: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1.5,
        ),
      ),
      controller: controller.searchController,
      onChanged: (value) {
        controller.searchProduct(value);
      },
      showSortButton: false,
    );
  }

  Widget _buildCategoryPicker(CategoryController categoryController) {
    return Obx(
      () => SelectedWidget(
        onTap: () => _showCategoryBottomSheet(categoryController),
        child: _buildCategoryPickerContent(categoryController),
      ),
    );
  }

  Widget _buildCategoryPickerContent(CategoryController categoryController) {
    final theme = Theme.of(Get.context!);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _selectedCategoryTitle(categoryController),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.colorScheme.onSurface,
          ),
        ],
      ),
    );
  }

  Widget _buildListMetaRow() {
    final theme = Theme.of(Get.context!);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Text(
            'showing_products'.trParams({
              's': controller.listProduct.length.toString(),
            }),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'newest'.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: theme.colorScheme.onSurface,
            ),
          ],
        ),
      ],
    );
  }

  String _selectedCategoryTitle(CategoryController categoryController) {
    final selectedIndex = controller.currentFilterIndex.value;
    if (selectedIndex == 0) {
      return 'all_categories'.tr;
    }

    final categoryIndex = selectedIndex - 1;
    if (categoryIndex < 0 ||
        categoryIndex >= categoryController.listCategory.length) {
      return 'all_categories'.tr;
    }

    return categoryController.listCategory[categoryIndex].name;
  }

  void _showCategoryBottomSheet(CategoryController categoryController) {
    final theme = Theme.of(Get.context!);
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.65),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomSheetHandle(),
              _buildBottomSheetHeader(),
              Divider(
                height: 1,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
              ),
              _buildCategoryBottomSheetList(categoryController),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBottomSheetHandle() {
    final theme = Theme.of(Get.context!);
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildBottomSheetHeader() {
    final theme = Theme.of(Get.context!);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'select_category'.tr,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.close_rounded, color: theme.colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBottomSheetList(CategoryController categoryController) {
    final theme = Theme.of(Get.context!);
    return Flexible(
      child: Obx(
        () => ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: categoryController.listCategory.length + 1,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              return CategorySortCard(
                title: 'all'.tr,
                isSelected: controller.currentFilterIndex.value == 0,
                onTap: () => _selectAllCategories(),
              );
            }

            final item = categoryController.listCategory[index - 1];
            return CategorySortCard(
              title: item.name,
              isSelected: controller.currentFilterIndex.value == index,
              onTap: () => _selectCategory(index: index, categoryId: item.id),
            );
          },
        ),
      ),
    );
  }

  void _selectAllCategories() {
    controller.currentFilterIndex.value = 0;
    controller.fetchListProduct(isLoadMore: false);
    Get.back();
  }

  void _selectCategory({required int index, required int categoryId}) {
    controller.currentFilterIndex.value = index;
    controller.onSelectedFilter(categoryId);
    Get.back();
  }


}
