import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/base_view/base_view.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/navigation_bar/profile_app_bar.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/home/presentation/home_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/home/presentation/widget/fast_feature_card.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';

import '../../../core/common_widget/button/selected_widget.dart';
import '../../../core/common_widget/dialog/dialog_x.dart';
import '../../../core/common_widget/input/text_input_field.dart';
import '../../../gen/assets.gen.dart';

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

  SliverToBoxAdapter _buildOverviewSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewHeader(context),
            const SizedBox(height: 16),
            _buildTotalProductCard(context),
            const SizedBox(height: 16),
            _buildSmallInfoCards(context),
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
        Text('Tong quan kho', style: context.textTheme.titleLarge),
        Text(
          'Cap nhat luc: 08:30 AM, 24/10/2023',
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildTotalProductCard(BuildContext context) {
    return _buildInfoCard(
      icon: Assets.icons.productCount.svg(),
      iconColor: ColorName.orange,
      hasGrow: true,
      context: context,
    );
  }

  Widget _buildSmallInfoCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            icon: Assets.icons.allCategory.svg(),
            iconColor: ColorName.blueLight,
            context: context,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInfoCard(
            icon: Assets.icons.lowProduct.svg(),
            iconColor: ColorName.error,
            context: context,
          ),
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildFastFeatureSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Loi tat nhanh',context),
            const SizedBox(height: 16),
            _buildFastFeatureActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600
      ),
    );
  }

  Widget _buildFastFeatureActions(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildAddProductAction()),
        const SizedBox(width: 16),
        Expanded(child: _buildAddCategoryAction(context)),
      ],
    );
  }

  Widget _buildAddProductAction() {
    return FastFeatureCard(
      filledColor: ColorName.orange,
      borderColor: ColorName.orange,
      icon: Assets.icons.whiteAdd.svg(),
      title: 'Them san pham',
      textColor: Colors.white,
      onTap: () {
        Get.toNamed(Routes.productsInfo);
      },
    );
  }

  Widget _buildAddCategoryAction(BuildContext context) {
    return FastFeatureCard(
      filledColor: context.theme.colorScheme.secondary.withValues(alpha: 0.2),
      borderColor: context.theme.colorScheme.surface.withValues(alpha: 0.2),
      icon: Assets.icons.whiteFolder.svg(),
      title: 'Them danh muc',
      textColor: Colors.white,
      onTap: fastAddCategoryMethod,
    );
  }

  void fastAddCategoryMethod() {
    final categoryController = Get.find<CategoryController>();
    Get.showCustomDialog(
      content: _buildFastAddCategoryContent(categoryController),
      title: 'Them danh muc',
      footer: _buildFastAddCategoryFooter(categoryController),
    );
  }

  Widget _buildFastAddCategoryContent(CategoryController categoryController) {
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
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          filledColor: Colors.white,
          onChanged: (value) {
            categoryController.addCategoryText.value = value;
          },
          controller: categoryController.addController,
        ),
      ],
    );
  }

  Widget _buildFastAddCategoryFooter(CategoryController categoryController) {
    return SelectedWidget(
      onTap: () {
        Get.back();
        categoryController.addCategory();
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          'Luu',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Container _buildInfoCard({
    required Widget icon,
    required Color iconColor,
    bool hasGrow = false,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface.withValues(alpha: 0.4),
        border: Border.all(
          color: context.theme.colorScheme.secondary.withValues(alpha: 0.4),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCardHeader(
            icon: icon,
            iconColor: iconColor,
            hasGrow: hasGrow,
          ),
          const SizedBox(height: 16),
          _buildInfoCardText(context),
        ],
      ),
    );
  }

  Widget _buildInfoCardHeader({
    required Widget icon,
    required Color iconColor,
    required bool hasGrow,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoIcon(icon: icon, iconColor: iconColor),
        if (hasGrow) _buildGrowBadge(),
      ],
    );
  }

  Widget _buildInfoIcon({required Widget icon, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withValues(alpha: 0.4), width: 2),
      ),
      child: icon,
    );
  }

  Widget _buildGrowBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: ColorName.greenLight.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorName.greenLight.withValues(alpha: 0.6),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.icons.growUp.svg(),
          const Text(
            ' +12%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorName.greenLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCardText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tong san pham', style: context.textTheme.titleSmall),
        const SizedBox(height: 2),
        Text('1200', style: context.textTheme.headlineSmall),
      ],
    );
  }
}
