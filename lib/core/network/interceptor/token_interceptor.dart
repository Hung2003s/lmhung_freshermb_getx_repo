import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lmhung_freshermb_getx_repo/core/utils/app_toast.dart';

import '../../navigation/routes.dart';
import '../../storage/secure_storage/token/token_manager.dart';

class TokenInterceptor extends Interceptor {
  bool _isRefreshing = false;

  TokenInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print(
        "=== TokenInterceptor NHAN LOI ${err.response?.statusCode}: ${err.requestOptions.path}",
      );
    }
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // Tránh spam redirect khi nhiều request cùng lỗi 401
    if (_isRefreshing) {
      return handler.reject(err);
    }

    _isRefreshing = true;
    try {
      AppToast.showError(
        title: 'session_expired'.tr,
        message: 'pls_login_again'.tr,
      );
      await Get.find<TokenManager>().clearToken();
      Get.offAllNamed(Routes.login);
      // Reject để Dio pipeline biết request đã fail
      return handler.reject(err);
    } finally {
      _isRefreshing = false;
    }
  }
}
