// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateCategoryParam {

@JsonKey(name: 'name') String get name;
/// Create a copy of UpdateCategoryParam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCategoryParamCopyWith<UpdateCategoryParam> get copyWith => _$UpdateCategoryParamCopyWithImpl<UpdateCategoryParam>(this as UpdateCategoryParam, _$identity);

  /// Serializes this UpdateCategoryParam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCategoryParam&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'UpdateCategoryParam(name: $name)';
}


}

/// @nodoc
abstract mixin class $UpdateCategoryParamCopyWith<$Res>  {
  factory $UpdateCategoryParamCopyWith(UpdateCategoryParam value, $Res Function(UpdateCategoryParam) _then) = _$UpdateCategoryParamCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name') String name
});




}
/// @nodoc
class _$UpdateCategoryParamCopyWithImpl<$Res>
    implements $UpdateCategoryParamCopyWith<$Res> {
  _$UpdateCategoryParamCopyWithImpl(this._self, this._then);

  final UpdateCategoryParam _self;
  final $Res Function(UpdateCategoryParam) _then;

/// Create a copy of UpdateCategoryParam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateCategoryParam].
extension UpdateCategoryParamPatterns on UpdateCategoryParam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateCategoryParam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateCategoryParam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateCategoryParam value)  $default,){
final _that = this;
switch (_that) {
case _UpdateCategoryParam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateCategoryParam value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateCategoryParam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateCategoryParam() when $default != null:
return $default(_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String name)  $default,) {final _that = this;
switch (_that) {
case _UpdateCategoryParam():
return $default(_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'name')  String name)?  $default,) {final _that = this;
switch (_that) {
case _UpdateCategoryParam() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateCategoryParam implements UpdateCategoryParam {
  const _UpdateCategoryParam({@JsonKey(name: 'name') required this.name});
  factory _UpdateCategoryParam.fromJson(Map<String, dynamic> json) => _$UpdateCategoryParamFromJson(json);

@override@JsonKey(name: 'name') final  String name;

/// Create a copy of UpdateCategoryParam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCategoryParamCopyWith<_UpdateCategoryParam> get copyWith => __$UpdateCategoryParamCopyWithImpl<_UpdateCategoryParam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateCategoryParamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCategoryParam&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'UpdateCategoryParam(name: $name)';
}


}

/// @nodoc
abstract mixin class _$UpdateCategoryParamCopyWith<$Res> implements $UpdateCategoryParamCopyWith<$Res> {
  factory _$UpdateCategoryParamCopyWith(_UpdateCategoryParam value, $Res Function(_UpdateCategoryParam) _then) = __$UpdateCategoryParamCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name') String name
});




}
/// @nodoc
class __$UpdateCategoryParamCopyWithImpl<$Res>
    implements _$UpdateCategoryParamCopyWith<$Res> {
  __$UpdateCategoryParamCopyWithImpl(this._self, this._then);

  final _UpdateCategoryParam _self;
  final $Res Function(_UpdateCategoryParam) _then;

/// Create a copy of UpdateCategoryParam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_UpdateCategoryParam(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UpdateCategoryRes {

@JsonKey(name: 'data') bool get data;
/// Create a copy of UpdateCategoryRes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCategoryResCopyWith<UpdateCategoryRes> get copyWith => _$UpdateCategoryResCopyWithImpl<UpdateCategoryRes>(this as UpdateCategoryRes, _$identity);

  /// Serializes this UpdateCategoryRes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCategoryRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'UpdateCategoryRes(data: $data)';
}


}

/// @nodoc
abstract mixin class $UpdateCategoryResCopyWith<$Res>  {
  factory $UpdateCategoryResCopyWith(UpdateCategoryRes value, $Res Function(UpdateCategoryRes) _then) = _$UpdateCategoryResCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') bool data
});




}
/// @nodoc
class _$UpdateCategoryResCopyWithImpl<$Res>
    implements $UpdateCategoryResCopyWith<$Res> {
  _$UpdateCategoryResCopyWithImpl(this._self, this._then);

  final UpdateCategoryRes _self;
  final $Res Function(UpdateCategoryRes) _then;

/// Create a copy of UpdateCategoryRes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateCategoryRes].
extension UpdateCategoryResPatterns on UpdateCategoryRes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateCategoryRes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateCategoryRes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateCategoryRes value)  $default,){
final _that = this;
switch (_that) {
case _UpdateCategoryRes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateCategoryRes value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateCategoryRes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  bool data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateCategoryRes() when $default != null:
return $default(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  bool data)  $default,) {final _that = this;
switch (_that) {
case _UpdateCategoryRes():
return $default(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  bool data)?  $default,) {final _that = this;
switch (_that) {
case _UpdateCategoryRes() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateCategoryRes implements UpdateCategoryRes {
  const _UpdateCategoryRes({@JsonKey(name: 'data') required this.data});
  factory _UpdateCategoryRes.fromJson(Map<String, dynamic> json) => _$UpdateCategoryResFromJson(json);

@override@JsonKey(name: 'data') final  bool data;

/// Create a copy of UpdateCategoryRes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCategoryResCopyWith<_UpdateCategoryRes> get copyWith => __$UpdateCategoryResCopyWithImpl<_UpdateCategoryRes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateCategoryResToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCategoryRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'UpdateCategoryRes(data: $data)';
}


}

/// @nodoc
abstract mixin class _$UpdateCategoryResCopyWith<$Res> implements $UpdateCategoryResCopyWith<$Res> {
  factory _$UpdateCategoryResCopyWith(_UpdateCategoryRes value, $Res Function(_UpdateCategoryRes) _then) = __$UpdateCategoryResCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') bool data
});




}
/// @nodoc
class __$UpdateCategoryResCopyWithImpl<$Res>
    implements _$UpdateCategoryResCopyWith<$Res> {
  __$UpdateCategoryResCopyWithImpl(this._self, this._then);

  final _UpdateCategoryRes _self;
  final $Res Function(_UpdateCategoryRes) _then;

/// Create a copy of UpdateCategoryRes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_UpdateCategoryRes(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
