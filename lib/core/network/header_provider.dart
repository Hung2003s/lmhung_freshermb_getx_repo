import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../storage/secure_storage/token/token_manager.dart';

class HeaderProvider {
  Map<String, String> getDefaultHeader() {
    return {
      'Cache-Control': 'no-cache',
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'User-Agent': 'PostmanRuntime/7.51.0',
    };
  }

  Future<Map<String, String>> getAuthenticatedHeader() async {
    final Map<String, String> header = getDefaultHeader();
    final TokenManager tokenSource = Get.find<TokenManager>();
    // Gọi trực tiếp repository thông qua instance được inject, không lo khởi tạo
    final String? accessToken = await tokenSource.getToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      header['Authorization'] = accessToken.startsWith('Bearer ')
          ? accessToken
          : 'Bearer $accessToken';
    }
    return header;
  }
}
