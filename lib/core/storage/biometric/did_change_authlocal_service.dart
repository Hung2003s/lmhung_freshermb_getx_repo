import 'package:did_change_authlocal/did_change_authlocal.dart';

/// Service để phát hiện
/// dữ liệu sinh trắc học trên thiết bị có bị thay đổi hay không.
/// Mục đích: Trước khi gọi `local_auth.authenticate()`, kiểm tra
/// xem người dùng có thêm/xoá vân tay/khuôn mặt trên thiết bị không.
/// Nếu có thay đổi -> chặn đăng nhập sinh trắc học, yêu cầu nhập mật khẩu.
class DidChangeAuthLocalService {
  final DidChangeAuthLocal _plugin = DidChangeAuthLocal.instance;

  /// Lấy token đại diện cho trạng thái sinh trắc học hiện tại của thiết bị.
  /// Token này cần được lưu lại (cùng lúc lưu credential sinh trắc học)
  /// để so sánh ở các lần kiểm tra sau.
  Future<String> getCurrentToken() async {
    return _plugin.getTokenBiometric();
  }

  /// Kiểm tra xem dữ liệu sinh trắc học có bị thay đổi không.
  /// [savedToken] là token đã lưu trước đó .
  /// Trả về:
  /// - [AuthLocalStatus.valid]   -> không thay đổi, an toàn để xác thực.
  /// - [AuthLocalStatus.changed] -> đã thay đổi, phải chặn & yêu cầu mật khẩu.
  /// - [AuthLocalStatus.invalid] -> sinh trắc học không khả dụng / lỗi.
  Future<AuthLocalStatus?> checkBiometricChanged({String? savedToken}) async {
    return _plugin.onCheckBiometric(token: savedToken);
  }

  /// Ghi nhận trạng thái sinh trắc học mới là "an toàn" sau khi người dùng
  /// đã xác thực lại bằng mật khẩu tài khoản.
  /// Sau khi gọi hàm này, các lần [checkBiometricChanged] tiếp theo sẽ
  /// trả về [AuthLocalStatus.valid] cho tới khi sinh trắc học lại thay đổi.
  Future<bool> acknowledgeChange() async {
    return _plugin.acknowledgeChange();
  }

  /// Stream theo dõi realtime mọi thay đổi sinh trắc học trên thiết bị.
  Stream<AuthLocalStatus> get onBiometricChanged => _plugin.onBiometricChanged;
}
