import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';

import '../../product/presentation/product_controller.dart';

class DashboardController extends GetxController {
  // Quản lý tab đang được chọn (mặc định là tab 0)
  var currentTabIndex = 0.obs;


  // final PageController pageController = PageController();
  final hideNavBar = false.obs;
  //mang danh dau tab nao da duoc kich hoat lan dau hay chua:

  final  initializedTabs = <bool>[true, false, false, false, false].obs;
  void changeTab(int index) {
    // Nếu bấm lại vào tab đang chọn -> refresh (cuộn lên đầu)
    if (currentTabIndex.value == index) {
      _handleDoubleTap(index);
      return;
    }

    if (!initializedTabs[index]) {
      initializedTabs[index] = true;
      initializedTabs.refresh();
    }

    currentTabIndex.value = index;
    // pageController.jumpToPage(index);
  }
  //Logic trở vể trạng thái trước khi chuyển tab của tab cũ
  void _handleDoubleTap(int index) {
    switch (index) {
      case (0):
      case (1):
      //Kiểm tra xem Controller có còn hay không
        if (Get.isRegistered<CategoryController>()) {

          final categoryControl = Get.find<CategoryController>();
          // Ví dụ: Cuộn lên đầu và refresh
          if (categoryControl.scrollController.hasClients) {
            // cuộn lên đầu trang
            categoryControl.scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
          categoryControl.getListCategory();
        }
        break;
      case (2):
        if (Get.isRegistered<ProductController>()) {

          final productControl = Get.find<ProductController>();
          // Ví dụ: Cuộn lên đầu và refresh
          if (productControl.scrollController.hasClients) {
            // cuộn lên đầu trang
            productControl.scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
          productControl.fetchListProduct(isLoadMore: false);
        }
        break;
      case (3):
        break;
      default:
        break;
    }
  }
}
