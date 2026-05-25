import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import 'package:lmhung_freshermb_getx_repo/core/utils/token_utils.dart';
import '../secure_storage_service.dart';

class TokenManager extends GetxService {

  // Biến Rx để các màn hình hoặc controller khác có thể lôi ra check xem đã login chưa
  final RxnString _accessToken = RxnString();
  final Rxn<DateTime?> _tokenExpiry = Rxn<DateTime?>();

  String? get accessToken => _accessToken.value;

  bool get isLoggedIn => _accessToken.value != null;

  /// Kiểm tra token còn hạn hay không
  bool get isTokenValid {
    if (_accessToken.value == null) return false;
    if (_tokenExpiry.value == null) return false;
    return DateTime.now().isBefore(_tokenExpiry.value!);
  }

  // Hàm khởi tạo để đọc token cũ lên ngay khi bật app
  Future<TokenManager> init() async {
    _accessToken.value = await SecureStorageService.readData(Constants.accessTokenKey);
    
    // Đọc thời gian hết hạn từ storage
    final expiryString = await SecureStorageService.readData(Constants.tokenExpiryKey);
    if (expiryString != null) {
      _tokenExpiry.value = DateTime.tryParse(expiryString);
    }
    
    // Nếu chưa có thời gian hết hạn trong storage, decode từ token
    if (_accessToken.value != null && _tokenExpiry.value == null) {
      final expTime = TokenUtils.getExpirationTime(_accessToken.value!);
      if (expTime != null) {
        _tokenExpiry.value = expTime;
        await SecureStorageService.writeData(Constants.tokenExpiryKey, expTime.toIso8601String());
      }
    }
    
    return this;
  }

  // Hàm lưu token khi login thành công
  Future<void> saveToken(String token) async {
    await SecureStorageService.writeData(Constants.accessTokenKey, token);
    
    // Giải mã và lưu thời gian hết hạn từ token
    final expTime = TokenUtils.getExpirationTime(token);
    if (expTime != null) {
      _tokenExpiry.value = expTime;
      await SecureStorageService.writeData(Constants.tokenExpiryKey, expTime.toIso8601String());
    }
  }

  // Hàm xóa token khi logout
  Future<void> clearToken() async {
    _accessToken.value = null;
    _tokenExpiry.value = null;
    await SecureStorageService.removeData(Constants.accessTokenKey);
    await SecureStorageService.removeData(Constants.tokenExpiryKey);
  }

  Future<String?> getToken() async  {
    return await SecureStorageService.readData(Constants.accessTokenKey);
  }
}
