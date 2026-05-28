import 'package:freezed_annotation/freezed_annotation.dart';
part 'data_state.freezed.dart';
part 'data_state.g.dart';

@freezed
abstract class ResponseError with _$ResponseError {
  factory ResponseError({
    @JsonKey(name: 'status_code') int? statusCode,
    @JsonKey(name: 'root_err') dynamic rootErr,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'log') String? log,
    @JsonKey(name: 'error_key') String? errorKey,
  }) = _ResponseError;
  factory ResponseError.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorFromJson(json);
}

// lib/core/network/data/data_state.dart
abstract class DataState<T> {
  final T? data;
  final ResponseError? error; // Giữ nguyên ResponseError ở đây

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(ResponseError error) : super(error: error);
}
