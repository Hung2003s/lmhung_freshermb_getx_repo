
import '../../../../../core/constants/constants.dart';
import '../../../../../core/storage/secure_storage_service.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl  implements AuthLocalDataSource {



  @override
  Future<void> clearToken() {
    return SecureStorageService.removeData(Constants.accessTokenKey);
  }

  @override
  Future<String?> getToken() async  {
    return await SecureStorageService.readData(Constants.accessTokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    return await SecureStorageService.writeData(Constants.accessTokenKey, token);
  }

}