import 'dart:convert';

class TokenUtils {
  /// Cắt chuỗi và giải mã JWT
  static Map<String, dynamic>? decodeJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      final payload = parts[1];
      final normalizedPayload = _normalizeBase64(payload);
      final decodedBytes = base64Decode(normalizedPayload);
      final decodedString = utf8.decode(decodedBytes);

      return jsonDecode(decodedString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  ///Hàm lấy thời gian hết hạn của token
  static DateTime? getExpirationTime(String token) {
    final payload = decodeJwt(token);
    if (payload == null || !payload.containsKey('exp')) {
      return null;
    }

    final exp = payload['exp'];
    if (exp is! int) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }

  ///Kiểm tra token còn hạn hay không
  static bool isTokenExpired(String token) {
    final expirationTime = getExpirationTime(token);
    if (expirationTime == null) {
      return true;
    }

    return DateTime.now().isAfter(expirationTime);
  }

  static Duration? getRemainingTime(String token) {
    final expirationTime = getExpirationTime(token);
    if (expirationTime == null) {
      return null;
    }

    return expirationTime.difference(DateTime.now());
  }

  /// Định dạng lại token nếu format sai
  static String _normalizeBase64(String str) {
    String normalized = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (normalized.length % 4) {
      case 2:
        normalized += '==';
        break;
      case 3:
        normalized += '=';
        break;
    }
    return normalized;
  }
}
