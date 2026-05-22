// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterParams _$RegisterParamsFromJson(Map<String, dynamic> json) =>
    _RegisterParams(
      userName: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterParamsToJson(_RegisterParams instance) =>
    <String, dynamic>{
      'username': instance.userName,
      'password': instance.password,
    };

_RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    _RegisterResponse(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(_RegisterResponse instance) =>
    <String, dynamic>{'data': instance.data};

_Data _$DataFromJson(Map<String, dynamic> json) =>
    _Data(accessToken: json['access_token'] as String);

Map<String, dynamic> _$DataToJson(_Data instance) => <String, dynamic>{
  'access_token': instance.accessToken,
};
