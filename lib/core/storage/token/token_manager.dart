import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import '../secure_storage_service.dart';

class TokenManager extends GetxService {



  // Biến Rx để các màn hình hoặc controller khác có thể lôi ra check xem đã login chưa
  final RxnString _accessToken = RxnString();

  String? get accessToken => _accessToken.value;

  bool get isLoggedIn => _accessToken.value != null;

  // Hàm khởi tạo để đọc token cũ lên ngay khi bật app
  Future<TokenManager> init() async {
    _accessToken.value = await SecureStorageService.readData(Constants.accessTokenKey);
    return this;
  }

  // Hàm lưu token khi login thành công
  Future<void> saveToken(String token) async {
    return await SecureStorageService.writeData(Constants.accessTokenKey, token);
  }

  // Hàm xóa token khi logout
  Future<void> clearToken() async {
    return await SecureStorageService.removeData(Constants.accessTokenKey);
  }

  Future<String?> getToken() async  {
    return await SecureStorageService.readData(Constants.accessTokenKey);
  }
}
