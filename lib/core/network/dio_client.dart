import 'package:dio/dio.dart';
import '../../core/config/app_config.dart';
import 'interceptor/curl_log_interceptor.dart';
import 'interceptor/header_interceptor.dart';

class DioClient {
  DioClient._privateConstructor();
  static final DioClient _instance = DioClient._privateConstructor();
  static DioClient get instance => _instance;

  //Cau hinh dio
  late final Dio _dio;
  Dio get dio => _dio;

  DioClient() {
    final options = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Cache-Control': 'no-cache',
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );
    _dio = Dio(options);
    _dio.interceptors.addAll([
      HeaderInterceptor(),
      CurlLogInterceptor(),
    ]);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = true,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(extra: {'requiresToken': requiresToken}),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data, required bool requiresToken}) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: Options(extra: {'requiresToken': requiresToken}),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data, required bool requiresToken}) async {
    try {
      return await _dio.put(path, data: data,
          options: Options(extra: {'requiresToken': requiresToken}));
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String path, {dynamic data, required bool requiresToken}) async {
    try {
      return await _dio.delete(path, data: data,
        options: Options(extra: {'requiresToken': requiresToken}),);
    } catch (e) {
      rethrow;
    }
  }
}
