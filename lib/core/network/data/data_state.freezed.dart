// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResponseError {

@JsonKey(name: 'status_code') int? get statusCode;@JsonKey(name: 'root_err') dynamic get rootErr;@JsonKey(name: 'message') String? get message;@JsonKey(name: 'log') String? get log;@JsonKey(name: 'error_key') String? get errorKey;
/// Create a copy of ResponseError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResponseErrorCopyWith<ResponseError> get copyWith => _$ResponseErrorCopyWithImpl<ResponseError>(this as ResponseError, _$identity);

  /// Serializes this ResponseError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResponseError&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.rootErr, rootErr)&&(identical(other.message, message) || other.message == message)&&(identical(other.log, log) || other.log == log)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,const DeepCollectionEquality().hash(rootErr),message,log,errorKey);

@override
String toString() {
  return 'ResponseError(statusCode: $statusCode, rootErr: $rootErr, message: $message, log: $log, errorKey: $errorKey)';
}


}

/// @nodoc
abstract mixin class $ResponseErrorCopyWith<$Res>  {
  factory $ResponseErrorCopyWith(ResponseError value, $Res Function(ResponseError) _then) = _$ResponseErrorCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'status_code') int? statusCode,@JsonKey(name: 'root_err') dynamic rootErr,@JsonKey(name: 'message') String? message,@JsonKey(name: 'log') String? log,@JsonKey(name: 'error_key') String? errorKey
});




}
/// @nodoc
class _$ResponseErrorCopyWithImpl<$Res>
    implements $ResponseErrorCopyWith<$Res> {
  _$ResponseErrorCopyWithImpl(this._self, this._then);

  final ResponseError _self;
  final $Res Function(ResponseError) _then;

/// Create a copy of ResponseError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = freezed,Object? rootErr = freezed,Object? message = freezed,Object? log = freezed,Object? errorKey = freezed,}) {
  return _then(_self.copyWith(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,rootErr: freezed == rootErr ? _self.rootErr : rootErr // ignore: cast_nullable_to_non_nullable
as dynamic,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,log: freezed == log ? _self.log : log // ignore: cast_nullable_to_non_nullable
as String?,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResponseError].
extension ResponseErrorPatterns on ResponseError {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResponseError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResponseError() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResponseError value)  $default,){
final _that = this;
switch (_that) {
case _ResponseError():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResponseError value)?  $default,){
final _that = this;
switch (_that) {
case _ResponseError() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'status_code')  int? statusCode, @JsonKey(name: 'root_err')  dynamic rootErr, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'log')  String? log, @JsonKey(name: 'error_key')  String? errorKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResponseError() when $default != null:
return $default(_that.statusCode,_that.rootErr,_that.message,_that.log,_that.errorKey);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'status_code')  int? statusCode, @JsonKey(name: 'root_err')  dynamic rootErr, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'log')  String? log, @JsonKey(name: 'error_key')  String? errorKey)  $default,) {final _that = this;
switch (_that) {
case _ResponseError():
return $default(_that.statusCode,_that.rootErr,_that.message,_that.log,_that.errorKey);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'status_code')  int? statusCode, @JsonKey(name: 'root_err')  dynamic rootErr, @JsonKey(name: 'message')  String? message, @JsonKey(name: 'log')  String? log, @JsonKey(name: 'error_key')  String? errorKey)?  $default,) {final _that = this;
switch (_that) {
case _ResponseError() when $default != null:
return $default(_that.statusCode,_that.rootErr,_that.message,_that.log,_that.errorKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResponseError implements ResponseError {
   _ResponseError({@JsonKey(name: 'status_code') this.statusCode, @JsonKey(name: 'root_err') this.rootErr, @JsonKey(name: 'message') this.message, @JsonKey(name: 'log') this.log, @JsonKey(name: 'error_key') this.errorKey});
  factory _ResponseError.fromJson(Map<String, dynamic> json) => _$ResponseErrorFromJson(json);

@override@JsonKey(name: 'status_code') final  int? statusCode;
@override@JsonKey(name: 'root_err') final  dynamic rootErr;
@override@JsonKey(name: 'message') final  String? message;
@override@JsonKey(name: 'log') final  String? log;
@override@JsonKey(name: 'error_key') final  String? errorKey;

/// Create a copy of ResponseError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResponseErrorCopyWith<_ResponseError> get copyWith => __$ResponseErrorCopyWithImpl<_ResponseError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResponseErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResponseError&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.rootErr, rootErr)&&(identical(other.message, message) || other.message == message)&&(identical(other.log, log) || other.log == log)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,const DeepCollectionEquality().hash(rootErr),message,log,errorKey);

@override
String toString() {
  return 'ResponseError(statusCode: $statusCode, rootErr: $rootErr, message: $message, log: $log, errorKey: $errorKey)';
}


}

/// @nodoc
abstract mixin class _$ResponseErrorCopyWith<$Res> implements $ResponseErrorCopyWith<$Res> {
  factory _$ResponseErrorCopyWith(_ResponseError value, $Res Function(_ResponseError) _then) = __$ResponseErrorCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'status_code') int? statusCode,@JsonKey(name: 'root_err') dynamic rootErr,@JsonKey(name: 'message') String? message,@JsonKey(name: 'log') String? log,@JsonKey(name: 'error_key') String? errorKey
});




}
/// @nodoc
class __$ResponseErrorCopyWithImpl<$Res>
    implements _$ResponseErrorCopyWith<$Res> {
  __$ResponseErrorCopyWithImpl(this._self, this._then);

  final _ResponseError _self;
  final $Res Function(_ResponseError) _then;

/// Create a copy of ResponseError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = freezed,Object? rootErr = freezed,Object? message = freezed,Object? log = freezed,Object? errorKey = freezed,}) {
  return _then(_ResponseError(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,rootErr: freezed == rootErr ? _self.rootErr : rootErr // ignore: cast_nullable_to_non_nullable
as dynamic,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,log: freezed == log ? _self.log : log // ignore: cast_nullable_to_non_nullable
as String?,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
