import 'package:dio/dio.dart';
import '../data/data_state.dart'; // Trỏ ngược ra thư mục data lấy data_state

mixin RemoteExceptionHandler {
  /// Hàm xử lý Exception dùng chung cho các RemoteData
  DataState<T> handleNetworkException<T>(Object e) {
    if (e is DioException) {
      if (e.response != null && e.response?.data != null) {
        try {
          // Bóc tách JSON lỗi từ server dựa trên cấu trúc ResponseError của bạn
          final errorResponse = ResponseError.fromJson(e.response!.data);
          return DataFailed(errorResponse);
        } catch (_) {
          return DataFailed(ResponseError(message: 'Lỗi hệ thống từ máy chủ'));
        }
      }

      // Bắt các trường hợp lỗi kết nối, timeout
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return DataFailed(ResponseError(message: 'Kết nối mạng quá hạn (Timeout)'));
      }

      return DataFailed(ResponseError(message: 'Mất kết nối mạng hoặc lỗi server'));
    }

    // Nếu dính các lỗi logic code khác (Null pointer, Cast type sai...) thì throw ra để debug
    throw Exception('$e');
  }
}