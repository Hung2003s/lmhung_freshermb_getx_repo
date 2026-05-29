import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
abstract class LoginParams with _$LoginParams {
  const factory LoginParams({
    @JsonKey(name: 'username') required String userName,
    @JsonKey(name: 'password') required String password,
  }) = _LoginParams;

  factory LoginParams.fromJson(Map<String, dynamic> json) =>
      _$LoginParamsFromJson(json);
}

@freezed
abstract class LoginResponse with _$LoginResponse {
  factory LoginResponse({@JsonKey(name: 'data') required Data data}) =
      _LoginResponse;
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
abstract class Data with _$Data {
  factory Data({@JsonKey(name: 'access_token') required String accessToken}) =
      _Data;
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
