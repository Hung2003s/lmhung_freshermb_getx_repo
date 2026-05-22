// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    _ProductResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      paging: json['paging'] == null
          ? null
          : Paging.fromJson(json['paging'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductResponseToJson(_ProductResponse instance) =>
    <String, dynamic>{'data': instance.data, 'paging': instance.paging};

_ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => _ProductItem(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  status: (json['status'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  code: json['code'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  stock: (json['stock'] as num?)?.toInt(),
  category: json['category'] == null
      ? null
      : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
  description: json['description'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$ProductItemToJson(_ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'code': instance.code,
      'price': instance.price,
      'stock': instance.stock,
      'category': instance.category,
      'description': instance.description,
      'image': instance.image,
    };

_Paging _$PagingFromJson(Map<String, dynamic> json) => _Paging(
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  count: (json['count'] as num?)?.toInt(),
);

Map<String, dynamic> _$PagingToJson(_Paging instance) => <String, dynamic>{
  'page': instance.page,
  'limit': instance.limit,
  'count': instance.count,
};

_ProductInfoParam _$ProductInfoParamFromJson(Map<String, dynamic> json) =>
    _ProductInfoParam(
      name: json['name'] as String,
      code: json['code'] as String,
      price: (json['price'] as num?)?.toDouble(),
      stock: (json['stock'] as num?)?.toInt(),
      category: (json['category_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ProductInfoParamToJson(_ProductInfoParam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'price': instance.price,
      'stock': instance.stock,
      'category_id': instance.category,
      'description': instance.description,
      'image': instance.image,
    };

_UpdateProductRes _$UpdateProductResFromJson(Map<String, dynamic> json) =>
    _UpdateProductRes(data: json['data'] as bool);

Map<String, dynamic> _$UpdateProductResToJson(_UpdateProductRes instance) =>
    <String, dynamic>{'data': instance.data};

_DeleteProductRes _$DeleteProductResFromJson(Map<String, dynamic> json) =>
    _DeleteProductRes(data: json['data'] as bool);

Map<String, dynamic> _$DeleteProductResToJson(_DeleteProductRes instance) =>
    <String, dynamic>{'data': instance.data};

_AddProductRes _$AddProductResFromJson(Map<String, dynamic> json) =>
    _AddProductRes(data: (json['data'] as num).toInt());

Map<String, dynamic> _$AddProductResToJson(_AddProductRes instance) =>
    <String, dynamic>{'data': instance.data};
