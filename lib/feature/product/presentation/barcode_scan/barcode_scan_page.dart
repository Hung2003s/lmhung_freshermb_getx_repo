import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/base_view/base_view.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entity/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/barcode_scan/barcode_scan_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/widget/product_card.dart';
import 'package:lmhung_freshermb_getx_repo/gen/assets.gen.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';

class BarcodeScanPage extends GetView<BarcodeScanController> {
  const BarcodeScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseView(
      backgroundColor: theme.scaffoldBackgroundColor,
      buildAppBar: _buildAppBar(theme),
      buildBody: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            _buildScanStatusCard(theme),
            const SizedBox(height: 16),
            _buildLastScannedCode(theme),
            const SizedBox(height: 16),
            Expanded(child: _buildSelectedProductList(theme)),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text(
        'barcode_scan'.tr,
        style: TextStyle(color: theme.colorScheme.onSurface),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.qr_code_scanner, color: ColorName.blueLight),
          tooltip: 'scan_with_camera'.tr,
          onPressed: () => controller.startCameraScan(),
        ),
        Obx(
          () => controller.selectedProducts.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.delete_sweep, color: ColorName.error),
                  tooltip: 'clear_all'.tr,
                  onPressed: () => controller.clearAll(),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildScanStatusCard(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface.withValues(alpha: 0.1),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorName.greenLight.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Assets.icons.whiteAdd.svg(
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                ColorName.greenLight,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'scanning_status'.tr,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    'scanned_count'.trParams({
                      'count': controller.selectedProducts.length.toString(),
                    }),
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ColorName.greenLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'scanning'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastScannedCode(ThemeData theme) {
    return Obx(
      () => controller.lastScannedCode.value.isNotEmpty
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorName.orange.withValues(alpha: 0.1),
                border: Border.all(
                  color: ColorName.orange.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.qr_code_scanner,
                    color: ColorName.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'last_scanned'.trParams({
                        'code': controller.lastScannedCode.value,
                      }),
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildSelectedProductList(ThemeData theme) {
    return Obx(() {
      if (controller.selectedProducts.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.qr_code_scanner,
                size: 64,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 16),
              Text(
                'scan_barcode_to_start'.tr,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.separated(
        itemCount: controller.selectedProducts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = controller.selectedProducts[index];
          return _buildSelectedProductCard(item, theme);
        },
      );
    });
  }

  Widget _buildSelectedProductCard(ProductEntity item, ThemeData theme) {
    return ProductCard(
      icon: Assets.icons.whiteFolder.svg(width: 16),
      iconColor: ColorName.blueLight,
      productEntity: item,
      categoryStatus: 'in_stock'.tr,
      onTap: () => _onProductTap(item),
      onDelete: () => controller.removeProduct(item.id),
    );
  }

  void _onProductTap(ProductEntity item) {
    Get.toNamed(Routes.productsInfo, arguments: item);
  }
}
