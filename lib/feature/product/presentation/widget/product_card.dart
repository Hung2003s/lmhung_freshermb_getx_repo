import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/selected_widget.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entity/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

class ProductCard extends StatelessWidget {
  final Widget icon;
  final Color iconColor;
  final ProductEntity productEntity;
  final String categoryStatus;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.categoryStatus,
    required this.onTap,
    required this.productEntity,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Slidable(
      key: ValueKey(productEntity.id),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          const SizedBox(width: 12,),
          Expanded(
            child: SelectedWidget(
              borderRadius: BorderRadius.circular(12),
              onTap: onDelete,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withValues(alpha: 0.2),
                  border: BoxBorder.all(
                    width: 2,
                    color: theme.colorScheme.error.withValues(alpha: 0.4),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "delete".tr,
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      child: SelectedWidget(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsetsGeometry.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsetsGeometry.all(20),
                decoration: BoxDecoration(
                  color: iconColor,
                  border: Border.all(color: iconColor.withValues(alpha: 0.2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: icon,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productEntity.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${"sku_code".tr}: SP-IP15-256',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        statusCard(
                          title: "in_stock".tr,
                          color: ColorName.greenLight,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'products_count'.trParams({'s': productEntity.stock.toString()}),
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(Icons.keyboard_arrow_right_outlined, color: theme.colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container statusCard({required String title, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        border: BoxBorder.all(color: color.withValues(alpha: 0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
          child: Text(
            'in_stock'.tr,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}