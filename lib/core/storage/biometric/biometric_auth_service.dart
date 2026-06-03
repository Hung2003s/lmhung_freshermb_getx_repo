import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../localization/locale_keys.dart';

class BiometricAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Kiểm tra nếu thiết bị hỗ trợ đăng nhập sinh học
  Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        return await _localAuth.isDeviceSupported();
      }
      return isAvailable;
    } on PlatformException {
      return false;
    }
  }

  /// Lấy danh sách các loại xác thực sinh học
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException {
      return [];
    }
  }

  /// Đăng nhập bằng xác thực sinh học
  /// Trả về `false` nếu bị lockout, user cancel hoặc lỗi — không throw exception
  Future<bool> authenticate({
    required String reason,
    bool biometricOnly = true,
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        biometricOnly: biometricOnly,
      );
    } on LocalAuthException catch (e) {
      switch (e.code) {
        case LocalAuthExceptionCode.userCanceled:
          return false;
        case LocalAuthExceptionCode.temporaryLockout:
        case LocalAuthExceptionCode.biometricLockout:
          // Không throw, trả về false để controller xử lý
          return false;
        default:
          return false;
      }
    }
  }

  /// Kiểm tra xem gần đây có bị lockout không (do sai quá nhiều lần)
  Future<bool> isLockedOut() async {
    try {
      // Nếu authenticate trả về false mà không có user cancel thì khả năng bị lock
      final canCheck = await _localAuth.canCheckBiometrics;
      return !canCheck;
    } catch (_) {
      return false;
    }
  }

  /// Lấy loại xác thực sinh học để hiển thị
  Future<String> getBiometricDisplayName() async {
    final available = await getAvailableBiometrics();
    if (available.contains(BiometricType.face)) {
      return LocaleKeys.faceId.tr;
    } else if (available.contains(BiometricType.fingerprint)) {
      return LocaleKeys.fingerprint.tr;
    } else if (available.contains(BiometricType.strong)) {
      return LocaleKeys.biometric.tr;
    }
    return LocaleKeys.biometric.tr;
  }
}

class BiometricException implements Exception {
  final String message;

  const BiometricException({required this.message});

  @override
  String toString() => message;
}
