import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  // Lỗi từ phía Server/API (Truyền message bóc từ ErrorResponse vào đây)
  const factory Failure.serverFailure({
    required String message,
    int? statusCode,
  }) = ServerFailure;

  // Lỗi kết nối mạng (Không có ErrorResponse vì không tới được Server)
  const factory Failure.connectionFailure({
    @Default('Không có kết nối internet') String message,
  }) = ConnectionFailure;

  // Lỗi xác thực (Hết hạn token, sai tài khoản)
  const factory Failure.authFailure({
    required String message,
  }) = AuthFailure;

  // Lỗi dữ liệu không hợp lệ từ local
  const factory Failure.validationFailure({
    required String message,
  }) = ValidationFailure;
}