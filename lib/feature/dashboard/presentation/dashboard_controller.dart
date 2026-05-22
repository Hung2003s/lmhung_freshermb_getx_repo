import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Quản lý tab đang được chọn (mặc định là tab 0)
  var currentTabIndex = 0.obs;

  void changeTab(int index) {
    currentTabIndex.value = index;
  }
}