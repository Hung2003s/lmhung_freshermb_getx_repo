import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final _storage = FlutterSecureStorage(aOptions: AndroidOptions());
  //ham clear tat ca du lieu
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  static Future<void> removeData(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key: key, value: value.toString());
  }

  static Future<String?> readData<T>(String key) async {
    try {
      return await _storage.read(key: key);
    } on PlatformException {
      // Xử lý lỗi giải mã
      // Xảy ra khi dữ liệu mã hóa cũ không tương thích với phiên bản mới
      // hoặc keystore đã thay đổi (sau khi reinstall app)
      try {
        // Xóa dữ liệu bị lỗi
        await _storage.delete(key: key);
      } catch (_) {
        // Bỏ qua nếu xóa thất bại
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Lưu một Object
  static Future<void> writeObject<T>(String key, T object) async {
    final String jsonString = jsonEncode(object);
    await _storage.write(key: key, value: jsonString);
  }

  /// Lấy một Object
  static Future<T?> readObject<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final String? jsonString = await _storage.read(key: key);
      if (jsonString != null && jsonString.isNotEmpty) {
        try {
          final Map<String, dynamic> map = jsonDecode(jsonString);
          return fromJson(map);
        } catch (e) {
          return null;
        }
      }
    } on PlatformException {
      // Xử lý lỗi giải mã tương tự readData
      try {
        await _storage.delete(key: key);
      } catch (_) {}
    } catch (e) {
      // Bỏ qua các lỗi khác
    }
    return null;
  }
}
