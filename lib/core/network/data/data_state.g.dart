// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResponseError _$ResponseErrorFromJson(Map<String, dynamic> json) =>
    _ResponseError(
      statusCode: (json['status_code'] as num?)?.toInt(),
      rootErr: json['root_err'],
      message: json['message'] as String?,
      log: json['log'] as String?,
      errorKey: json['error_key'] as String?,
    );

Map<String, dynamic> _$ResponseErrorToJson(_ResponseError instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'root_err': instance.rootErr,
      'message': instance.message,
      'log': instance.log,
      'error_key': instance.errorKey,
    };
