import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/animation/gradient_border_animation.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/selected_widget.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/input/custom_search_field.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/state/empty_state_widget.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/soft_option_enums.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entities/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/product_card.dart';
import '../../../core/common_widget/base_view/base_view.dart';
import '../../../core/gen/assets.gen.dart';
import '../../../core/gen/colors.gen.dart';
import '../../../core/navigation/routes.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseView(
      backgroundColor: theme.scaffoldBackgroundColor,
      buildBody: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
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
          LocaleKeys.products.tr,
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
      onTap: () => controller.navigateToInfo(),
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
    return Stack(
      children: [
        // ListView — luôn mounted, chỉ rebuild khi listProduct thay đổi
        Obx(
          () => controller.listProduct.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: controller.scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.listProduct.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = controller.listProduct[index];
                          final isLastItem =
                              index == controller.listProduct.length - 1;
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
                          return const SizedBox(height: 8);
                        },
                      ),
                    ),
                    Obx(
                      () => controller.isLoadingMore.value
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorName.orange,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
        ),
        // Loading/Error/Empty states — Obx riêng, không ảnh hưởng ListView
        Obx(() {
          if (controller.isLoading.value && controller.listProduct.isEmpty) {
            return const LoadingStateWidget();
          }
          if (controller.errorMessage.value.isNotEmpty &&
              controller.listProduct.isEmpty) {
            return ErrorStateWidget(
              message: controller.errorMessage.value,
              onRetry: () => controller.fetchListProduct(isLoadMore: false),
            );
          }
          if (controller.listProduct.isEmpty && !controller.isLoading.value) {
            return EmptyStateWidget(
              icon: Icons.inventory_2_outlined,
              title: LocaleKeys.noProductsFound.tr,
              subtitle: LocaleKeys.tryAddingProduct.tr,
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildProductCard(ProductEntity item) {
    return RepaintBoundary(
      child: ProductCard(
        icon: Assets.icons.whiteFolder.svg(width: 16),
        iconColor: ColorName.blueLight,
        productEntity: item,
        categoryStatus: LocaleKeys.inStock.tr,
        onTap: () => controller.navigateToInfo(item),
        onDelete: () => controller.deleteProductAction(item),
      ),
    );
  }

  Widget _buildBarcodeScanButton(ThemeData theme) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.barcodeScan);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: const Icon(
          Icons.qr_code_scanner_rounded,
          color: ColorName.orange,
          size: 24,
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
        Row(
          children: [
            Expanded(
              child: GradientBorderAnimation(child: _buildSearchField()),
            ),
            const SizedBox(width: 8),
            _buildBarcodeScanButton(theme),
          ],
        ),
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
                  tooltip: LocaleKeys.sortFilter.tr,
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
        borderSide: BorderSide(color: Colors.transparent, width: 1.5),
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
        onTap: () => controller.showCategoryBottomSheet(),
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
              controller.selectedCategoryTitle(categoryController),
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
            LocaleKeys.showingProducts.trParams({
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
              LocaleKeys.newest.tr,
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
}
