// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_delete_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeleteCategoryRes {

@JsonKey(name: 'data') bool get data;
/// Create a copy of DeleteCategoryRes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteCategoryResCopyWith<DeleteCategoryRes> get copyWith => _$DeleteCategoryResCopyWithImpl<DeleteCategoryRes>(this as DeleteCategoryRes, _$identity);

  /// Serializes this DeleteCategoryRes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteCategoryRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'DeleteCategoryRes(data: $data)';
}


}

/// @nodoc
abstract mixin class $DeleteCategoryResCopyWith<$Res>  {
  factory $DeleteCategoryResCopyWith(DeleteCategoryRes value, $Res Function(DeleteCategoryRes) _then) = _$DeleteCategoryResCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') bool data
});




}
/// @nodoc
class _$DeleteCategoryResCopyWithImpl<$Res>
    implements $DeleteCategoryResCopyWith<$Res> {
  _$DeleteCategoryResCopyWithImpl(this._self, this._then);

  final DeleteCategoryRes _self;
  final $Res Function(DeleteCategoryRes) _then;

/// Create a copy of DeleteCategoryRes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DeleteCategoryRes].
extension DeleteCategoryResPatterns on DeleteCategoryRes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteCategoryRes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteCategoryRes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteCategoryRes value)  $default,){
final _that = this;
switch (_that) {
case _DeleteCategoryRes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteCategoryRes value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteCategoryRes() when $default != null:
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
case _DeleteCategoryRes() when $default != null:
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
case _DeleteCategoryRes():
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
case _DeleteCategoryRes() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeleteCategoryRes implements DeleteCategoryRes {
  const _DeleteCategoryRes({@JsonKey(name: 'data') required this.data});
  factory _DeleteCategoryRes.fromJson(Map<String, dynamic> json) => _$DeleteCategoryResFromJson(json);

@override@JsonKey(name: 'data') final  bool data;

/// Create a copy of DeleteCategoryRes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteCategoryResCopyWith<_DeleteCategoryRes> get copyWith => __$DeleteCategoryResCopyWithImpl<_DeleteCategoryRes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeleteCategoryResToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteCategoryRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'DeleteCategoryRes(data: $data)';
}


}

/// @nodoc
abstract mixin class _$DeleteCategoryResCopyWith<$Res> implements $DeleteCategoryResCopyWith<$Res> {
  factory _$DeleteCategoryResCopyWith(_DeleteCategoryRes value, $Res Function(_DeleteCategoryRes) _then) = __$DeleteCategoryResCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') bool data
});




}
/// @nodoc
class __$DeleteCategoryResCopyWithImpl<$Res>
    implements _$DeleteCategoryResCopyWith<$Res> {
  __$DeleteCategoryResCopyWithImpl(this._self, this._then);

  final _DeleteCategoryRes _self;
  final $Res Function(_DeleteCategoryRes) _then;

/// Create a copy of DeleteCategoryRes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_DeleteCategoryRes(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
