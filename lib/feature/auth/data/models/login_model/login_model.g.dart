// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginParams _$LoginParamsFromJson(Map<String, dynamic> json) => _LoginParams(
  userName: json['username'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$LoginParamsToJson(_LoginParams instance) =>
    <String, dynamic>{
      'username': instance.userName,
      'password': instance.password,
    };

_LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    _LoginResponse(data: Data.fromJson(json['data'] as Map<String, dynamic>));

Map<String, dynamic> _$LoginResponseToJson(_LoginResponse instance) =>
    <String, dynamic>{'data': instance.data};

_Data _$DataFromJson(Map<String, dynamic> json) =>
    _Data(accessToken: json['access_token'] as String);

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
  'access_token': instance.accessToken,
};
