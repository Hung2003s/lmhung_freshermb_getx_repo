import 'package:lmhung_freshermb_getx_repo/core/storage/secure_storage/token/token_manager.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/repositories/categories_repository.dart';

class LogoutUseCase {
  final TokenManager _tokenManager;
  final CategoriesRepository _categoriesRepository;

  LogoutUseCase({
    required TokenManager tokenManager,
    required CategoriesRepository categoriesRepository,
  })  : _tokenManager = tokenManager,
        _categoriesRepository = categoriesRepository;

  Future<void> call() async {
    await _tokenManager.clearToken();
    _categoriesRepository.clearCache();
  }
}
