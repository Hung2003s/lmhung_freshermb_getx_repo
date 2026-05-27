// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_add_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryAddParams {

@JsonKey(name: 'name') String get name;
/// Create a copy of CategoryAddParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryAddParamsCopyWith<CategoryAddParams> get copyWith => _$CategoryAddParamsCopyWithImpl<CategoryAddParams>(this as CategoryAddParams, _$identity);

  /// Serializes this CategoryAddParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryAddParams&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'CategoryAddParams(name: $name)';
}


}

/// @nodoc
abstract mixin class $CategoryAddParamsCopyWith<$Res>  {
  factory $CategoryAddParamsCopyWith(CategoryAddParams value, $Res Function(CategoryAddParams) _then) = _$CategoryAddParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name') String name
});




}
/// @nodoc
class _$CategoryAddParamsCopyWithImpl<$Res>
    implements $CategoryAddParamsCopyWith<$Res> {
  _$CategoryAddParamsCopyWithImpl(this._self, this._then);

  final CategoryAddParams _self;
  final $Res Function(CategoryAddParams) _then;

/// Create a copy of CategoryAddParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryAddParams].
extension CategoryAddParamsPatterns on CategoryAddParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryAddParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryAddParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryAddParams value)  $default,){
final _that = this;
switch (_that) {
case _CategoryAddParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryAddParams value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryAddParams() when $default != null:
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
case _CategoryAddParams() when $default != null:
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
case _CategoryAddParams():
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
case _CategoryAddParams() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryAddParams implements CategoryAddParams {
  const _CategoryAddParams({@JsonKey(name: 'name') required this.name});
  factory _CategoryAddParams.fromJson(Map<String, dynamic> json) => _$CategoryAddParamsFromJson(json);

@override@JsonKey(name: 'name') final  String name;

/// Create a copy of CategoryAddParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryAddParamsCopyWith<_CategoryAddParams> get copyWith => __$CategoryAddParamsCopyWithImpl<_CategoryAddParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryAddParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryAddParams&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'CategoryAddParams(name: $name)';
}


}

/// @nodoc
abstract mixin class _$CategoryAddParamsCopyWith<$Res> implements $CategoryAddParamsCopyWith<$Res> {
  factory _$CategoryAddParamsCopyWith(_CategoryAddParams value, $Res Function(_CategoryAddParams) _then) = __$CategoryAddParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name') String name
});




}
/// @nodoc
class __$CategoryAddParamsCopyWithImpl<$Res>
    implements _$CategoryAddParamsCopyWith<$Res> {
  __$CategoryAddParamsCopyWithImpl(this._self, this._then);

  final _CategoryAddParams _self;
  final $Res Function(_CategoryAddParams) _then;

/// Create a copy of CategoryAddParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_CategoryAddParams(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CategoryAddRes {

@JsonKey(name: 'data') int get data;
/// Create a copy of CategoryAddRes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryAddResCopyWith<CategoryAddRes> get copyWith => _$CategoryAddResCopyWithImpl<CategoryAddRes>(this as CategoryAddRes, _$identity);

  /// Serializes this CategoryAddRes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryAddRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CategoryAddRes(data: $data)';
}


}

/// @nodoc
abstract mixin class $CategoryAddResCopyWith<$Res>  {
  factory $CategoryAddResCopyWith(CategoryAddRes value, $Res Function(CategoryAddRes) _then) = _$CategoryAddResCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') int data
});




}
/// @nodoc
class _$CategoryAddResCopyWithImpl<$Res>
    implements $CategoryAddResCopyWith<$Res> {
  _$CategoryAddResCopyWithImpl(this._self, this._then);

  final CategoryAddRes _self;
  final $Res Function(CategoryAddRes) _then;

/// Create a copy of CategoryAddRes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryAddRes].
extension CategoryAddResPatterns on CategoryAddRes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryAddRes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryAddRes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryAddRes value)  $default,){
final _that = this;
switch (_that) {
case _CategoryAddRes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryAddRes value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryAddRes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  int data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryAddRes() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  int data)  $default,) {final _that = this;
switch (_that) {
case _CategoryAddRes():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  int data)?  $default,) {final _that = this;
switch (_that) {
case _CategoryAddRes() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryAddRes implements CategoryAddRes {
  const _CategoryAddRes({@JsonKey(name: 'data') required this.data});
  factory _CategoryAddRes.fromJson(Map<String, dynamic> json) => _$CategoryAddResFromJson(json);

@override@JsonKey(name: 'data') final  int data;

/// Create a copy of CategoryAddRes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryAddResCopyWith<_CategoryAddRes> get copyWith => __$CategoryAddResCopyWithImpl<_CategoryAddRes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryAddResToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryAddRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CategoryAddRes(data: $data)';
}


}

/// @nodoc
abstract mixin class _$CategoryAddResCopyWith<$Res> implements $CategoryAddResCopyWith<$Res> {
  factory _$CategoryAddResCopyWith(_CategoryAddRes value, $Res Function(_CategoryAddRes) _then) = __$CategoryAddResCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') int data
});




}
/// @nodoc
class __$CategoryAddResCopyWithImpl<$Res>
    implements _$CategoryAddResCopyWith<$Res> {
  __$CategoryAddResCopyWithImpl(this._self, this._then);

  final _CategoryAddRes _self;
  final $Res Function(_CategoryAddRes) _then;

/// Create a copy of CategoryAddRes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_CategoryAddRes(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
