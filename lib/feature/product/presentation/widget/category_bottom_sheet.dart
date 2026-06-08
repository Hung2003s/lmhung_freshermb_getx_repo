import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/category_sort_card.dart';

/// Bottom sheet hiển thị danh sách category để filter sản phẩm.
/// Tách ra khỏi ProductController để controller chỉ chứa logic.
void showCategoryFilterBottomSheet({
  required ProductController productController,
}) {
  final categoryController = Get.find<CategoryController>();
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
            _CategorySheetHandle(theme: theme),
            _CategorySheetHeader(theme: theme),
            Divider(
              height: 1,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
            ),
            _CategorySheetList(
              theme: theme,
              categoryController: categoryController,
              productController: productController,
            ),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class _CategorySheetHandle extends StatelessWidget {
  final ThemeData theme;
  const _CategorySheetHandle({required this.theme});

  @override
  Widget build(BuildContext context) {
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
}

class _CategorySheetHeader extends StatelessWidget {
  final ThemeData theme;
  const _CategorySheetHeader({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LocaleKeys.selectCategory.tr,
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
}

class _CategorySheetList extends StatelessWidget {
  final ThemeData theme;
  final CategoryController categoryController;
  final ProductController productController;

  const _CategorySheetList({
    required this.theme,
    required this.categoryController,
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
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
              return RepaintBoundary(
                child: CategorySortCard(
                  title: LocaleKeys.all.tr,
                  isSelected: productController.currentFilterIndex.value == 0,
                  onTap: () {
                    productController.currentFilterIndex.value = 0;
                    productController.onSelectedFilter(0);
                    Get.back();
                  },
                ),
              );
            }
            final item = categoryController.listCategory[index - 1];
            return RepaintBoundary(
              child: CategorySortCard(
                title: item.name,
                isSelected: productController.currentFilterIndex.value == index,
                onTap: () {
                  productController.currentFilterIndex.value = index;
                  productController.onSelectedFilter(item.id);
                  Get.back();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
