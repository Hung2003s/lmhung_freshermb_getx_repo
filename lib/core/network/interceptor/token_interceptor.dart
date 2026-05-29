import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lmhung_freshermb_getx_repo/core/utils/app_toast.dart';

import '../../../navigation/routes.dart';
import '../../storage/secure_storage/token/token_manager.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print(
        "=== TokenInterceptor NHAN LOI 401: ${err.response?.statusCode} for ${err.requestOptions.path}",
      );
    }
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }
    AppToast.showError(
      title: 'session_expired'.tr,
      message: 'pls_login_again'.tr,
    );
    await Get.find<TokenManager>().clearToken();
    Get.offAllNamed(Routes.login);
  }
}
