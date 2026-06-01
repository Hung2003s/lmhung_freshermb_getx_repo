import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/base_view/base_view.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/navigation_bar/profile_app_bar.dart';
import 'package:lmhung_freshermb_getx_repo/feature/home/presentation/home_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/home/presentation/widget/fast_feature_card.dart';
import 'package:lmhung_freshermb_getx_repo/feature/home/presentation/widget/info_card.dart';

import '../../../core/gen/assets.gen.dart';
import '../../../core/gen/colors.gen.dart';
import '../../../core/navigation/routes.dart';


class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      buildAppBar: ProfileAppBar(username: 'Le Minh Hung'),
      buildBody: CustomScrollView(
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        controller: controller.contactScrollCtrl,
        slivers: <Widget>[
          _buildOverviewSection(context),
          _buildFastFeatureSection(context),
        ],
      ),
    );
  }

  /// Tổng quan kho hàng
  SliverToBoxAdapter _buildOverviewSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Tổng quan kho hàng
            _buildOverviewHeader(context),
            const SizedBox(height: 16),
            //Thông số hàng hoá
            InfoCard(
              icon: Assets.icons.productCount.svg(),
              iconColor: ColorName.orange,
              hasGrow: true,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    icon: Assets.icons.allCategory.svg(),
                    iconColor: ColorName.blueLight,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InfoCard(
                    icon: Assets.icons.lowProduct.svg(),
                    iconColor: ColorName.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('warehouse_overview'.tr, style: context.textTheme.titleLarge),
        Text('updated_at'.tr, style: context.textTheme.bodyMedium),
      ],
    );
  }

  //Phần chức năng nhanh
  SliverToBoxAdapter _buildFastFeatureSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(
              'quick_actions'.tr,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildFastFeatureActions(context),
          ],
        ),
      ),
    );
  }

  ///Các nút chức năng
  Widget _buildFastFeatureActions(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildAddProductAction()),
        const SizedBox(width: 16),
        Expanded(child: _buildAddCategoryAction()),
      ],
    );
  }

  //Card thêm sản phẩm
  Widget _buildAddProductAction() {
    return FastFeatureCard(
      rippleColor: Colors.grey,
      filledColor: ColorName.orange,
      borderColor: ColorName.orange,
      icon: Assets.icons.whiteAdd.svg(),
      title: 'add_product'.tr,
      textColor: Colors.white,
      onTap: () {
        Get.toNamed(Routes.productsInfo);
      },
    );
  }

  //Card thêm danh mục
  Widget _buildAddCategoryAction() {
    return FastFeatureCard(
      filledColor: Theme.of(
        Get.context!,
      ).colorScheme.secondary.withValues(alpha: 0.4),
      borderColor: Theme.of(
        Get.context!,
      ).colorScheme.surface.withValues(alpha: 0.2),
      icon: Assets.icons.whiteFolder.svg(),
      title: 'add_category'.tr,
      textColor: Colors.white,
      onTap: () => controller.fastAddCategoryMethod(),
    );
  }
}
