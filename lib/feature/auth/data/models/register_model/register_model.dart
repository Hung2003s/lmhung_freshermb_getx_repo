import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_model.freezed.dart';
part 'register_model.g.dart';

@freezed
abstract class RegisterParams with _$RegisterParams {
  const factory RegisterParams({
    @JsonKey(name: 'username') required String userName,
    @JsonKey(name: 'password') required String password,
  }) = _RegisterParams;

  factory RegisterParams.fromJson(Map<String, dynamic> json) =>
      _$RegisterParamsFromJson(json);
}

@freezed
abstract class RegisterResponse with _$RegisterResponse {
  factory RegisterResponse({@JsonKey(name: 'data') required Data data}) =
      _RegisterResponse;
  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}

@freezed
abstract class Data with _$Data {
  factory Data({@JsonKey(name: 'access_token') required String accessToken}) =
      _Data;
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
