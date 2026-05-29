/// Lỗi xảy ra khi gọi API (Server trả về 4xx, 5xx)
class ServerException implements Exception {
  final String? message;
  final int? statusCode;

  ServerException({this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Code: $statusCode)';
}

/// Lỗi xảy ra khi tương tác với Local Database (Hive, SQLite)
class CacheException implements Exception {
  final String message;
  CacheException({this.message = "Lỗi truy xuất dữ liệu cục bộ"});
}

/// Lỗi xảy ra khi không có kết nối Internet
class NetworkException implements Exception {}

/// Lỗi khi Token hết hạn hoặc không có quyền truy cập
class AuthException implements Exception {
  final String message;
  AuthException({this.message = "Phiên đăng nhập hết hạn"});
}
