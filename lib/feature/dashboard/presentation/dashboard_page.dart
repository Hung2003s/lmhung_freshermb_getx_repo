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
      const  HomePage(),
      const CategoryPage(),
       Container(),
      const ProductPage(),
       const SettingPage(),
    ];

    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Obx(() =>
              IndexedStack(
                index: controller.currentTabIndex.value,
                children: pages,
              )),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomFloatingNavBar(),
          ),
        ],
      ),
    );
  }
}
