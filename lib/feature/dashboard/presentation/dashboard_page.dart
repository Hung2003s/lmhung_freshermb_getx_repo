import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/dashboard/presentation/dashboard_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/dashboard/presentation/widget/navigation_bar.dart';
import 'package:lmhung_freshermb_getx_repo/feature/home/presentation/home_page.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_page.dart';
import 'package:lmhung_freshermb_getx_repo/feature/setting/presentation/setting_page.dart';

import '../../category/presentation/category_page.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const CategoryPage(),
      Container(),
      const ProductPage(),
      const SettingPage(),
    ];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(
            () => IndexedStack(
              index: controller.currentTabIndex.value,
              children: [
                _buildLazyTab(0, pages[0]),
                _buildLazyTab(1, pages[1]),
                _buildLazyTab(2, pages[2]),
                _buildLazyTab(3, pages[3]),
                _buildLazyTab(4, pages[4]),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomFloatingNavBar(),
          ),
        ],
      ),
    );
  }
  Widget _buildLazyTab(int index, Widget view) {
    // Check: Nếu tab này đã được đánh dấu HOẶC đang là tab được chọn
    if (controller.initializedTabs[index] == true) {
      return view;
    }
    return const SizedBox.shrink();
  }
}
