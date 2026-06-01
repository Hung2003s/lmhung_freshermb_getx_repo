import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/navigation/routes.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/presentation/login/login_binding.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/presentation/register/register_binding.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/presentation/register/register_page.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_binding.dart';
import 'package:lmhung_freshermb_getx_repo/feature/dashboard/presentation/dashboard_binding.dart';
import 'package:lmhung_freshermb_getx_repo/feature/dashboard/presentation/dashboard_page.dart';
import 'package:lmhung_freshermb_getx_repo/feature/home/presentation/home_bindings.dart';
import 'package:lmhung_freshermb_getx_repo/feature/home/presentation/home_page.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/barcode_scan/barcode_scan_binding.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/barcode_scan/barcode_scan_page.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_binding.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_info/product_info_binding.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_info/product_info_page.dart';
import 'package:lmhung_freshermb_getx_repo/feature/splash/splash_binding.dart';
import 'package:lmhung_freshermb_getx_repo/feature/splash/splash_page.dart';

import '../../feature/auth/presentation/login/login_page.dart';
import '../../feature/category/presentation/category_page.dart';
import '../../feature/product/presentation/product_page.dart';


class AppRouters {
  AppRouters._();

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
      bindings: [
        DashboardBinding(),
        CategoryBinding(),
        ProductBinding(),
        HomeBindings(),
      ],
    ),
    GetPage(
      name: Routes.category,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.products,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.productsInfo,
      page: () => const ProductInfoPage(),
      binding: ProductInfoBinding(),
    ),
    GetPage(
      name: Routes.barcodeScan,
      page: () => const BarcodeScanPage(),
      binding: BarcodeScanBinding(),
    ),
  ];
}
