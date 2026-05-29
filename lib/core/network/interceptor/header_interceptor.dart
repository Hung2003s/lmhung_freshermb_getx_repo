import 'package:dio/dio.dart';
import '../header_provider.dart';

class HeaderInterceptor extends Interceptor {
  final HeaderProvider _headerProvider = HeaderProvider();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Thêm Default Header (Content-Type, Accept, v.v.)
    options.headers.addAll(_headerProvider.getDefaultHeader());

    // 2. Kiểm tra xem request có yêu cầu Token hay không (mặc định là có)
    final bool requiresToken = options.extra['requiresToken'] ?? true;

    if (requiresToken) {
      // 3. Lấy headers đã bao gồm Authorization từ Provider
      final authenticatedHeader = await _headerProvider
          .getAuthenticatedHeader();
      options.headers.addAll(authenticatedHeader);
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
