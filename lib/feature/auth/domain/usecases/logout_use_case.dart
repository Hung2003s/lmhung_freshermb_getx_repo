import 'package:lmhung_freshermb_getx_repo/core/cache/cache_manager.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/secure_storage/token/token_manager.dart';

class LogoutUseCase {
  final TokenManager _tokenManager;
  final CacheManager _cacheManager;

  LogoutUseCase({
    required TokenManager tokenManager,
    required CacheManager cacheManager,
  })  : _tokenManager = tokenManager,
        _cacheManager = cacheManager;

  Future<void> call() async {
    await _tokenManager.clearToken();
    _cacheManager.invalidateAll();
  }
}
