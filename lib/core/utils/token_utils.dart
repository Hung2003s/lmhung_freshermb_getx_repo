import 'dart:convert';

class TokenUtils {
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

  static DateTime? getExpirationTime(String token) {
    final payload = decodeJwt(token);
    if (payload == null || !payload.containsKey('exp')) {
      return null;
    }

    final exp = payload['exp'];
    if (exp is! int) {
      return null;
    }

    // JWT exp is in Unix timestamp (seconds since epoch)
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }

  static bool isTokenExpired(String token) {
    final expirationTime = getExpirationTime(token);
    if (expirationTime == null) {
      return true; // Consider expired if no expiration time
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

  static String _normalizeBase64(String str) {
    // Replace URL-safe characters
    String normalized = str.replaceAll('-', '+').replaceAll('_', '/');

    // Add padding if needed
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