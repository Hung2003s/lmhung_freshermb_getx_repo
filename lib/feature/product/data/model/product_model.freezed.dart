// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductResponse {

@JsonKey(name: 'data') List<ProductItem>? get data;@JsonKey(name: 'paging') Paging? get paging;
/// Create a copy of ProductResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductResponseCopyWith<ProductResponse> get copyWith => _$ProductResponseCopyWithImpl<ProductResponse>(this as ProductResponse, _$identity);

  /// Serializes this ProductResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductResponse&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.paging, paging) || other.paging == paging));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),paging);

@override
String toString() {
  return 'ProductResponse(data: $data, paging: $paging)';
}


}

/// @nodoc
abstract mixin class $ProductResponseCopyWith<$Res>  {
  factory $ProductResponseCopyWith(ProductResponse value, $Res Function(ProductResponse) _then) = _$ProductResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<ProductItem>? data,@JsonKey(name: 'paging') Paging? paging
});


$PagingCopyWith<$Res>? get paging;

}
/// @nodoc
class _$ProductResponseCopyWithImpl<$Res>
    implements $ProductResponseCopyWith<$Res> {
  _$ProductResponseCopyWithImpl(this._self, this._then);

  final ProductResponse _self;
  final $Res Function(ProductResponse) _then;

/// Create a copy of ProductResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? paging = freezed,}) {
  return _then(_self.copyWith(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<ProductItem>?,paging: freezed == paging ? _self.paging : paging // ignore: cast_nullable_to_non_nullable
as Paging?,
  ));
}
/// Create a copy of ProductResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PagingCopyWith<$Res>? get paging {
    if (_self.paging == null) {
    return null;
  }

  return $PagingCopyWith<$Res>(_self.paging!, (value) {
    return _then(_self.copyWith(paging: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductResponse].
extension ProductResponsePatterns on ProductResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductResponse value)  $default,){
final _that = this;
switch (_that) {
case _ProductResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ProductResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<ProductItem>? data, @JsonKey(name: 'paging')  Paging? paging)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductResponse() when $default != null:
return $default(_that.data,_that.paging);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<ProductItem>? data, @JsonKey(name: 'paging')  Paging? paging)  $default,) {final _that = this;
switch (_that) {
case _ProductResponse():
return $default(_that.data,_that.paging);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<ProductItem>? data, @JsonKey(name: 'paging')  Paging? paging)?  $default,) {final _that = this;
switch (_that) {
case _ProductResponse() when $default != null:
return $default(_that.data,_that.paging);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductResponse extends ProductResponse {
  const _ProductResponse({@JsonKey(name: 'data') final  List<ProductItem>? data, @JsonKey(name: 'paging') this.paging}): _data = data,super._();
  factory _ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);

 final  List<ProductItem>? _data;
@override@JsonKey(name: 'data') List<ProductItem>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'paging') final  Paging? paging;

/// Create a copy of ProductResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductResponseCopyWith<_ProductResponse> get copyWith => __$ProductResponseCopyWithImpl<_ProductResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductResponse&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.paging, paging) || other.paging == paging));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),paging);

@override
String toString() {
  return 'ProductResponse(data: $data, paging: $paging)';
}


}

/// @nodoc
abstract mixin class _$ProductResponseCopyWith<$Res> implements $ProductResponseCopyWith<$Res> {
  factory _$ProductResponseCopyWith(_ProductResponse value, $Res Function(_ProductResponse) _then) = __$ProductResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<ProductItem>? data,@JsonKey(name: 'paging') Paging? paging
});


@override $PagingCopyWith<$Res>? get paging;

}
/// @nodoc
class __$ProductResponseCopyWithImpl<$Res>
    implements _$ProductResponseCopyWith<$Res> {
  __$ProductResponseCopyWithImpl(this._self, this._then);

  final _ProductResponse _self;
  final $Res Function(_ProductResponse) _then;

/// Create a copy of ProductResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? paging = freezed,}) {
  return _then(_ProductResponse(
data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<ProductItem>?,paging: freezed == paging ? _self.paging : paging // ignore: cast_nullable_to_non_nullable
as Paging?,
  ));
}

/// Create a copy of ProductResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PagingCopyWith<$Res>? get paging {
    if (_self.paging == null) {
    return null;
  }

  return $PagingCopyWith<$Res>(_self.paging!, (value) {
    return _then(_self.copyWith(paging: value));
  });
}
}


/// @nodoc
mixin _$ProductItem {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'name') String get name;@JsonKey(name: 'status') int? get status;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;@JsonKey(name: 'code') String? get code;@JsonKey(name: 'price') double? get price;@JsonKey(name: 'stock') int? get stock;@JsonKey(name: 'category') CategoryModel? get category;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'image') String? get image;
/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductItemCopyWith<ProductItem> get copyWith => _$ProductItemCopyWithImpl<ProductItem>(this as ProductItem, _$identity);

  /// Serializes this ProductItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.code, code) || other.code == code)&&(identical(other.price, price) || other.price == price)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,createdAt,updatedAt,code,price,stock,category,description,image);

@override
String toString() {
  return 'ProductItem(id: $id, name: $name, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, code: $code, price: $price, stock: $stock, category: $category, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class $ProductItemCopyWith<$Res>  {
  factory $ProductItemCopyWith(ProductItem value, $Res Function(ProductItem) _then) = _$ProductItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'name') String name,@JsonKey(name: 'status') int? status,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'code') String? code,@JsonKey(name: 'price') double? price,@JsonKey(name: 'stock') int? stock,@JsonKey(name: 'category') CategoryModel? category,@JsonKey(name: 'description') String? description,@JsonKey(name: 'image') String? image
});


$CategoryModelCopyWith<$Res>? get category;

}
/// @nodoc
class _$ProductItemCopyWithImpl<$Res>
    implements $ProductItemCopyWith<$Res> {
  _$ProductItemCopyWithImpl(this._self, this._then);

  final ProductItem _self;
  final $Res Function(ProductItem) _then;

/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? code = freezed,Object? price = freezed,Object? stock = freezed,Object? category = freezed,Object? description = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryModel?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductItem].
extension ProductItemPatterns on ProductItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductItem value)  $default,){
final _that = this;
switch (_that) {
case _ProductItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductItem value)?  $default,){
final _that = this;
switch (_that) {
case _ProductItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'status')  int? status, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'code')  String? code, @JsonKey(name: 'price')  double? price, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'category')  CategoryModel? category, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'image')  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductItem() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.createdAt,_that.updatedAt,_that.code,_that.price,_that.stock,_that.category,_that.description,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'status')  int? status, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'code')  String? code, @JsonKey(name: 'price')  double? price, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'category')  CategoryModel? category, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'image')  String? image)  $default,) {final _that = this;
switch (_that) {
case _ProductItem():
return $default(_that.id,_that.name,_that.status,_that.createdAt,_that.updatedAt,_that.code,_that.price,_that.stock,_that.category,_that.description,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'name')  String name, @JsonKey(name: 'status')  int? status, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'code')  String? code, @JsonKey(name: 'price')  double? price, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'category')  CategoryModel? category, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'image')  String? image)?  $default,) {final _that = this;
switch (_that) {
case _ProductItem() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.createdAt,_that.updatedAt,_that.code,_that.price,_that.stock,_that.category,_that.description,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductItem extends ProductItem {
  const _ProductItem({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'name') required this.name, @JsonKey(name: 'status') this.status, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'code') this.code, @JsonKey(name: 'price') this.price, @JsonKey(name: 'stock') this.stock, @JsonKey(name: 'category') this.category, @JsonKey(name: 'description') this.description, @JsonKey(name: 'image') this.image}): super._();
  factory _ProductItem.fromJson(Map<String, dynamic> json) => _$ProductItemFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'status') final  int? status;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
@override@JsonKey(name: 'code') final  String? code;
@override@JsonKey(name: 'price') final  double? price;
@override@JsonKey(name: 'stock') final  int? stock;
@override@JsonKey(name: 'category') final  CategoryModel? category;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'image') final  String? image;

/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductItemCopyWith<_ProductItem> get copyWith => __$ProductItemCopyWithImpl<_ProductItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.code, code) || other.code == code)&&(identical(other.price, price) || other.price == price)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,createdAt,updatedAt,code,price,stock,category,description,image);

@override
String toString() {
  return 'ProductItem(id: $id, name: $name, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, code: $code, price: $price, stock: $stock, category: $category, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ProductItemCopyWith<$Res> implements $ProductItemCopyWith<$Res> {
  factory _$ProductItemCopyWith(_ProductItem value, $Res Function(_ProductItem) _then) = __$ProductItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'name') String name,@JsonKey(name: 'status') int? status,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'code') String? code,@JsonKey(name: 'price') double? price,@JsonKey(name: 'stock') int? stock,@JsonKey(name: 'category') CategoryModel? category,@JsonKey(name: 'description') String? description,@JsonKey(name: 'image') String? image
});


@override $CategoryModelCopyWith<$Res>? get category;

}
/// @nodoc
class __$ProductItemCopyWithImpl<$Res>
    implements _$ProductItemCopyWith<$Res> {
  __$ProductItemCopyWithImpl(this._self, this._then);

  final _ProductItem _self;
  final $Res Function(_ProductItem) _then;

/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? code = freezed,Object? price = freezed,Object? stock = freezed,Object? category = freezed,Object? description = freezed,Object? image = freezed,}) {
  return _then(_ProductItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryModel?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// @nodoc
mixin _$Paging {

@JsonKey(name: 'page') int? get page;@JsonKey(name: 'limit') int? get limit;@JsonKey(name: 'count') int? get count;
/// Create a copy of Paging
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagingCopyWith<Paging> get copyWith => _$PagingCopyWithImpl<Paging>(this as Paging, _$identity);

  /// Serializes this Paging to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Paging&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,limit,count);

@override
String toString() {
  return 'Paging(page: $page, limit: $limit, count: $count)';
}


}

/// @nodoc
abstract mixin class $PagingCopyWith<$Res>  {
  factory $PagingCopyWith(Paging value, $Res Function(Paging) _then) = _$PagingCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'page') int? page,@JsonKey(name: 'limit') int? limit,@JsonKey(name: 'count') int? count
});




}
/// @nodoc
class _$PagingCopyWithImpl<$Res>
    implements $PagingCopyWith<$Res> {
  _$PagingCopyWithImpl(this._self, this._then);

  final Paging _self;
  final $Res Function(Paging) _then;

/// Create a copy of Paging
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = freezed,Object? limit = freezed,Object? count = freezed,}) {
  return _then(_self.copyWith(
page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Paging].
extension PagingPatterns on Paging {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Paging value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Paging() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Paging value)  $default,){
final _that = this;
switch (_that) {
case _Paging():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Paging value)?  $default,){
final _that = this;
switch (_that) {
case _Paging() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'page')  int? page, @JsonKey(name: 'limit')  int? limit, @JsonKey(name: 'count')  int? count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Paging() when $default != null:
return $default(_that.page,_that.limit,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'page')  int? page, @JsonKey(name: 'limit')  int? limit, @JsonKey(name: 'count')  int? count)  $default,) {final _that = this;
switch (_that) {
case _Paging():
return $default(_that.page,_that.limit,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'page')  int? page, @JsonKey(name: 'limit')  int? limit, @JsonKey(name: 'count')  int? count)?  $default,) {final _that = this;
switch (_that) {
case _Paging() when $default != null:
return $default(_that.page,_that.limit,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Paging implements Paging {
  const _Paging({@JsonKey(name: 'page') this.page, @JsonKey(name: 'limit') this.limit, @JsonKey(name: 'count') this.count});
  factory _Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);

@override@JsonKey(name: 'page') final  int? page;
@override@JsonKey(name: 'limit') final  int? limit;
@override@JsonKey(name: 'count') final  int? count;

/// Create a copy of Paging
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagingCopyWith<_Paging> get copyWith => __$PagingCopyWithImpl<_Paging>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PagingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Paging&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,limit,count);

@override
String toString() {
  return 'Paging(page: $page, limit: $limit, count: $count)';
}


}

/// @nodoc
abstract mixin class _$PagingCopyWith<$Res> implements $PagingCopyWith<$Res> {
  factory _$PagingCopyWith(_Paging value, $Res Function(_Paging) _then) = __$PagingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'page') int? page,@JsonKey(name: 'limit') int? limit,@JsonKey(name: 'count') int? count
});




}
/// @nodoc
class __$PagingCopyWithImpl<$Res>
    implements _$PagingCopyWith<$Res> {
  __$PagingCopyWithImpl(this._self, this._then);

  final _Paging _self;
  final $Res Function(_Paging) _then;

/// Create a copy of Paging
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = freezed,Object? limit = freezed,Object? count = freezed,}) {
  return _then(_Paging(
page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ProductInfoParam {

@JsonKey(name: 'name') String get name;@JsonKey(name: 'code') String get code;@JsonKey(name: 'price') double? get price;@JsonKey(name: 'stock') int? get stock;@JsonKey(name: 'category_id') int? get category;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'image') String? get image;
/// Create a copy of ProductInfoParam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductInfoParamCopyWith<ProductInfoParam> get copyWith => _$ProductInfoParamCopyWithImpl<ProductInfoParam>(this as ProductInfoParam, _$identity);

  /// Serializes this ProductInfoParam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductInfoParam&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.price, price) || other.price == price)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,price,stock,category,description,image);

@override
String toString() {
  return 'ProductInfoParam(name: $name, code: $code, price: $price, stock: $stock, category: $category, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class $ProductInfoParamCopyWith<$Res>  {
  factory $ProductInfoParamCopyWith(ProductInfoParam value, $Res Function(ProductInfoParam) _then) = _$ProductInfoParamCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name') String name,@JsonKey(name: 'code') String code,@JsonKey(name: 'price') double? price,@JsonKey(name: 'stock') int? stock,@JsonKey(name: 'category_id') int? category,@JsonKey(name: 'description') String? description,@JsonKey(name: 'image') String? image
});




}
/// @nodoc
class _$ProductInfoParamCopyWithImpl<$Res>
    implements $ProductInfoParamCopyWith<$Res> {
  _$ProductInfoParamCopyWithImpl(this._self, this._then);

  final ProductInfoParam _self;
  final $Res Function(ProductInfoParam) _then;

/// Create a copy of ProductInfoParam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? code = null,Object? price = freezed,Object? stock = freezed,Object? category = freezed,Object? description = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductInfoParam].
extension ProductInfoParamPatterns on ProductInfoParam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductInfoParam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductInfoParam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductInfoParam value)  $default,){
final _that = this;
switch (_that) {
case _ProductInfoParam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductInfoParam value)?  $default,){
final _that = this;
switch (_that) {
case _ProductInfoParam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String name, @JsonKey(name: 'code')  String code, @JsonKey(name: 'price')  double? price, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'category_id')  int? category, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'image')  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductInfoParam() when $default != null:
return $default(_that.name,_that.code,_that.price,_that.stock,_that.category,_that.description,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String name, @JsonKey(name: 'code')  String code, @JsonKey(name: 'price')  double? price, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'category_id')  int? category, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'image')  String? image)  $default,) {final _that = this;
switch (_that) {
case _ProductInfoParam():
return $default(_that.name,_that.code,_that.price,_that.stock,_that.category,_that.description,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'name')  String name, @JsonKey(name: 'code')  String code, @JsonKey(name: 'price')  double? price, @JsonKey(name: 'stock')  int? stock, @JsonKey(name: 'category_id')  int? category, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'image')  String? image)?  $default,) {final _that = this;
switch (_that) {
case _ProductInfoParam() when $default != null:
return $default(_that.name,_that.code,_that.price,_that.stock,_that.category,_that.description,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductInfoParam implements ProductInfoParam {
  const _ProductInfoParam({@JsonKey(name: 'name') required this.name, @JsonKey(name: 'code') required this.code, @JsonKey(name: 'price') this.price, @JsonKey(name: 'stock') this.stock, @JsonKey(name: 'category_id') this.category, @JsonKey(name: 'description') this.description, @JsonKey(name: 'image') this.image});
  factory _ProductInfoParam.fromJson(Map<String, dynamic> json) => _$ProductInfoParamFromJson(json);

@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'code') final  String code;
@override@JsonKey(name: 'price') final  double? price;
@override@JsonKey(name: 'stock') final  int? stock;
@override@JsonKey(name: 'category_id') final  int? category;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'image') final  String? image;

/// Create a copy of ProductInfoParam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductInfoParamCopyWith<_ProductInfoParam> get copyWith => __$ProductInfoParamCopyWithImpl<_ProductInfoParam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductInfoParamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductInfoParam&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.price, price) || other.price == price)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,price,stock,category,description,image);

@override
String toString() {
  return 'ProductInfoParam(name: $name, code: $code, price: $price, stock: $stock, category: $category, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ProductInfoParamCopyWith<$Res> implements $ProductInfoParamCopyWith<$Res> {
  factory _$ProductInfoParamCopyWith(_ProductInfoParam value, $Res Function(_ProductInfoParam) _then) = __$ProductInfoParamCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name') String name,@JsonKey(name: 'code') String code,@JsonKey(name: 'price') double? price,@JsonKey(name: 'stock') int? stock,@JsonKey(name: 'category_id') int? category,@JsonKey(name: 'description') String? description,@JsonKey(name: 'image') String? image
});




}
/// @nodoc
class __$ProductInfoParamCopyWithImpl<$Res>
    implements _$ProductInfoParamCopyWith<$Res> {
  __$ProductInfoParamCopyWithImpl(this._self, this._then);

  final _ProductInfoParam _self;
  final $Res Function(_ProductInfoParam) _then;

/// Create a copy of ProductInfoParam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? code = null,Object? price = freezed,Object? stock = freezed,Object? category = freezed,Object? description = freezed,Object? image = freezed,}) {
  return _then(_ProductInfoParam(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpdateProductRes {

@JsonKey(name: 'data') bool get data;
/// Create a copy of UpdateProductRes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProductResCopyWith<UpdateProductRes> get copyWith => _$UpdateProductResCopyWithImpl<UpdateProductRes>(this as UpdateProductRes, _$identity);

  /// Serializes this UpdateProductRes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProductRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'UpdateProductRes(data: $data)';
}


}

/// @nodoc
abstract mixin class $UpdateProductResCopyWith<$Res>  {
  factory $UpdateProductResCopyWith(UpdateProductRes value, $Res Function(UpdateProductRes) _then) = _$UpdateProductResCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') bool data
});




}
/// @nodoc
class _$UpdateProductResCopyWithImpl<$Res>
    implements $UpdateProductResCopyWith<$Res> {
  _$UpdateProductResCopyWithImpl(this._self, this._then);

  final UpdateProductRes _self;
  final $Res Function(UpdateProductRes) _then;

/// Create a copy of UpdateProductRes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateProductRes].
extension UpdateProductResPatterns on UpdateProductRes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateProductRes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateProductRes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateProductRes value)  $default,){
final _that = this;
switch (_that) {
case _UpdateProductRes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateProductRes value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateProductRes() when $default != null:
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
case _UpdateProductRes() when $default != null:
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
case _UpdateProductRes():
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
case _UpdateProductRes() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateProductRes implements UpdateProductRes {
  const _UpdateProductRes({@JsonKey(name: 'data') required this.data});
  factory _UpdateProductRes.fromJson(Map<String, dynamic> json) => _$UpdateProductResFromJson(json);

@override@JsonKey(name: 'data') final  bool data;

/// Create a copy of UpdateProductRes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProductResCopyWith<_UpdateProductRes> get copyWith => __$UpdateProductResCopyWithImpl<_UpdateProductRes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateProductResToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProductRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'UpdateProductRes(data: $data)';
}


}

/// @nodoc
abstract mixin class _$UpdateProductResCopyWith<$Res> implements $UpdateProductResCopyWith<$Res> {
  factory _$UpdateProductResCopyWith(_UpdateProductRes value, $Res Function(_UpdateProductRes) _then) = __$UpdateProductResCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') bool data
});




}
/// @nodoc
class __$UpdateProductResCopyWithImpl<$Res>
    implements _$UpdateProductResCopyWith<$Res> {
  __$UpdateProductResCopyWithImpl(this._self, this._then);

  final _UpdateProductRes _self;
  final $Res Function(_UpdateProductRes) _then;

/// Create a copy of UpdateProductRes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_UpdateProductRes(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DeleteProductRes {

@JsonKey(name: 'data') bool get data;
/// Create a copy of DeleteProductRes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteProductResCopyWith<DeleteProductRes> get copyWith => _$DeleteProductResCopyWithImpl<DeleteProductRes>(this as DeleteProductRes, _$identity);

  /// Serializes this DeleteProductRes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteProductRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'DeleteProductRes(data: $data)';
}


}

/// @nodoc
abstract mixin class $DeleteProductResCopyWith<$Res>  {
  factory $DeleteProductResCopyWith(DeleteProductRes value, $Res Function(DeleteProductRes) _then) = _$DeleteProductResCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') bool data
});




}
/// @nodoc
class _$DeleteProductResCopyWithImpl<$Res>
    implements $DeleteProductResCopyWith<$Res> {
  _$DeleteProductResCopyWithImpl(this._self, this._then);

  final DeleteProductRes _self;
  final $Res Function(DeleteProductRes) _then;

/// Create a copy of DeleteProductRes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DeleteProductRes].
extension DeleteProductResPatterns on DeleteProductRes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteProductRes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteProductRes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteProductRes value)  $default,){
final _that = this;
switch (_that) {
case _DeleteProductRes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteProductRes value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteProductRes() when $default != null:
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
case _DeleteProductRes() when $default != null:
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
case _DeleteProductRes():
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
case _DeleteProductRes() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeleteProductRes implements DeleteProductRes {
  const _DeleteProductRes({@JsonKey(name: 'data') required this.data});
  factory _DeleteProductRes.fromJson(Map<String, dynamic> json) => _$DeleteProductResFromJson(json);

@override@JsonKey(name: 'data') final  bool data;

/// Create a copy of DeleteProductRes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteProductResCopyWith<_DeleteProductRes> get copyWith => __$DeleteProductResCopyWithImpl<_DeleteProductRes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeleteProductResToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteProductRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'DeleteProductRes(data: $data)';
}


}

/// @nodoc
abstract mixin class _$DeleteProductResCopyWith<$Res> implements $DeleteProductResCopyWith<$Res> {
  factory _$DeleteProductResCopyWith(_DeleteProductRes value, $Res Function(_DeleteProductRes) _then) = __$DeleteProductResCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') bool data
});




}
/// @nodoc
class __$DeleteProductResCopyWithImpl<$Res>
    implements _$DeleteProductResCopyWith<$Res> {
  __$DeleteProductResCopyWithImpl(this._self, this._then);

  final _DeleteProductRes _self;
  final $Res Function(_DeleteProductRes) _then;

/// Create a copy of DeleteProductRes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_DeleteProductRes(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AddProductRes {

@JsonKey(name: 'data') int get data;
/// Create a copy of AddProductRes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddProductResCopyWith<AddProductRes> get copyWith => _$AddProductResCopyWithImpl<AddProductRes>(this as AddProductRes, _$identity);

  /// Serializes this AddProductRes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddProductRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AddProductRes(data: $data)';
}


}

/// @nodoc
abstract mixin class $AddProductResCopyWith<$Res>  {
  factory $AddProductResCopyWith(AddProductRes value, $Res Function(AddProductRes) _then) = _$AddProductResCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') int data
});




}
/// @nodoc
class _$AddProductResCopyWithImpl<$Res>
    implements $AddProductResCopyWith<$Res> {
  _$AddProductResCopyWithImpl(this._self, this._then);

  final AddProductRes _self;
  final $Res Function(AddProductRes) _then;

/// Create a copy of AddProductRes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AddProductRes].
extension AddProductResPatterns on AddProductRes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddProductRes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddProductRes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddProductRes value)  $default,){
final _that = this;
switch (_that) {
case _AddProductRes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddProductRes value)?  $default,){
final _that = this;
switch (_that) {
case _AddProductRes() when $default != null:
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
case _AddProductRes() when $default != null:
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
case _AddProductRes():
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
case _AddProductRes() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddProductRes implements AddProductRes {
  const _AddProductRes({@JsonKey(name: 'data') required this.data});
  factory _AddProductRes.fromJson(Map<String, dynamic> json) => _$AddProductResFromJson(json);

@override@JsonKey(name: 'data') final  int data;

/// Create a copy of AddProductRes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddProductResCopyWith<_AddProductRes> get copyWith => __$AddProductResCopyWithImpl<_AddProductRes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddProductResToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddProductRes&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AddProductRes(data: $data)';
}


}

/// @nodoc
abstract mixin class _$AddProductResCopyWith<$Res> implements $AddProductResCopyWith<$Res> {
  factory _$AddProductResCopyWith(_AddProductRes value, $Res Function(_AddProductRes) _then) = __$AddProductResCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') int data
});




}
/// @nodoc
class __$AddProductResCopyWithImpl<$Res>
    implements _$AddProductResCopyWith<$Res> {
  __$AddProductResCopyWithImpl(this._self, this._then);

  final _AddProductRes _self;
  final $Res Function(_AddProductRes) _then;

/// Create a copy of AddProductRes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_AddProductRes(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
