import 'dart:convert';

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
    return await _storage.read(key: key);
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
    final String? jsonString = await _storage.read(key: key);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final Map<String, dynamic> map = jsonDecode(jsonString);
        return fromJson(map);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
