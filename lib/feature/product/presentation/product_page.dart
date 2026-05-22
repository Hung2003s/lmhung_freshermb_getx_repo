import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/selected_widget.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/input/custom_search_field.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/soft_option_enums.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entity/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/product_card.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

import '../../../core/common_widget/base_view/base_view.dart';
import '../../../core/common_widget/dialog/dialog_x.dart';
import '../../../gen/assets.gen.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      backgroundColor: Colors.black,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'San pham',
          style: TextStyle(
            color: Colors.white,
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

      return ListView.builder(
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
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        controller.errorMessage.value,
        style: const TextStyle(
          color: Colors.white,
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
      categoryStatus: 'Còn hàng',
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ban co chac chan muon xoa san pham nay?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteDialogFooter(ProductEntity item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildDialogButton(title: 'Huy', onTap: () => Get.back()),
        const SizedBox(width: 12),
        _buildDialogButton(
          title: 'Xac nhan',
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
    return SelectedWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

  Widget _buildCategoryFilter() {
    final categoryController = Get.find<CategoryController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        _buildSearchField(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildCategoryPicker(categoryController)),
            const SizedBox(width: 16,),
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  )
                ),
                child: PopupMenuButton<SortOption>(
                  tooltip: 'Sắp xếp & Lọc',
                  color: Colors.black,
                  onSelected: (SortOption result) {
                    controller.currentSort.value = result;
                    controller.sortProduct(result);
                  },
                  itemBuilder: (BuildContext context) => SortOption.values.map((option) {
                    final isSelected = controller.currentSort.value == option;
                    return PopupMenuItem<SortOption>(
                      value: option,
                      child: Text(option.title, style: TextStyle(
                        color: isSelected ? ColorName.orange : Colors.white,
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),), // Tự động lấy string từ hàm get title của bạn
                    );
                  }).toList(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Hoặc Colors.grey.shade800 nếu dùng Dark Mode như ảnh
                      border: Border.all(color: Colors.grey), // Viền nút
                      borderRadius: BorderRadius.circular(8), // Bo góc giống ảnh của bạn
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Để Row tự co lại vừa với nội dung
                      children: [
                        const Icon(Icons.sort, size: 20, color: Colors.white,), // Icon bộ lọc
                        const SizedBox(width: 8),
                        // HIỂN THỊ TITLE CỦA ENUM ĐANG CHỌN TẠI ĐÂY
                        Text(
                          controller.currentSort.value.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.keyboard_arrow_down, size: 20), // Icon mũi tên chỉ xuống
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildListMetaRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Text(
            'Hien thi ${controller.listProduct.length} san pham',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Moi nhat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
          ],
        ),
      ],
    );
  }

  String _selectedCategoryTitle(CategoryController categoryController) {
    final selectedIndex = controller.currentFilterIndex.value;
    if (selectedIndex == 0) {
      return 'Tat ca danh muc';
    }

    final categoryIndex = selectedIndex - 1;
    if (categoryIndex < 0 ||
        categoryIndex >= categoryController.listCategory.length) {
      return 'Tat ca danh muc';
    }

    return categoryController.listCategory[categoryIndex].name;
  }

  void _showCategoryBottomSheet(CategoryController categoryController) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.65),
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomSheetHandle(),
              _buildBottomSheetHeader(),
              Divider(height: 1, color: Colors.white.withValues(alpha: 0.12)),
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
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildBottomSheetHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Chon danh muc',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBottomSheetList(CategoryController categoryController) {
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
            color: Colors.white.withValues(alpha: 0.08),
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _categoryBottomSheetItem(
                title: 'Tat ca',
                isSelected: controller.currentFilterIndex.value == 0,
                onTap: () => _selectAllCategories(),
              );
            }

            final item = categoryController.listCategory[index - 1];
            return _categoryBottomSheetItem(
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

  Widget _categoryBottomSheetItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return SelectedWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? ColorName.orange : Colors.white,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_rounded, color: ColorName.orange),
          ],
        ),
      ),
    );
  }
}
