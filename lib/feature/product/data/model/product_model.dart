import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../category/data/models/category_response/category_model.dart';
import '../../domain/entity/product_entity.dart';

part 'product_model.freezed.dart';

part 'product_model.g.dart';

@freezed
abstract class ProductResponse with _$ProductResponse {
  const ProductResponse._();

  const factory ProductResponse({
    @JsonKey(name: 'data') List<ProductItem>? data,
    @JsonKey(name: 'paging') Paging? paging,
  }) = _ProductResponse;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  List<ProductEntity> responseToListEntities() {
    final List<ProductEntity> listProduct;
    if (data != null && data!.isNotEmpty) {
      listProduct = data!.map((model) => model.modelToEntity()).toList();
      return listProduct;
    } else {
      return [];
    }
  }
}

@freezed
abstract class ProductItem with _$ProductItem {
  const ProductItem._();

  const factory ProductItem({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'code') String? code,
    @JsonKey(name: 'price') double? price,
    @JsonKey(name: 'stock') int? stock,
    @JsonKey(name: 'category') CategoryModel? category,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'image') String? image,
  }) = _ProductItem;

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  ProductEntity modelToEntity() {
    return ProductEntity(
      id: id,
      name: name,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      code: code,
      price: price ?? 0,
      stock: stock ?? 0,
      category: category?.modelToEntity(),
      description: description,
      image: image,
    );
  }
}

@freezed
abstract class Paging with _$Paging {
  const factory Paging({
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'limit') int? limit,
    @JsonKey(name: 'count') int? count,
  }) = _Paging;

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);
}

@freezed
abstract class ProductInfoParam with _$ProductInfoParam {
  const factory ProductInfoParam({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'price') double? price,
    @JsonKey(name: 'stock') int? stock,
    @JsonKey(name: 'category_id') int? category,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'image') String? image,
  }) = _ProductInfoParam;

  factory ProductInfoParam.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoParamFromJson(json);
}

@freezed
abstract class UpdateProductRes with _$UpdateProductRes {
  const factory UpdateProductRes({@JsonKey(name: 'data') required bool data}) =
      _UpdateProductRes;

  factory UpdateProductRes.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductResFromJson(json);
}

@freezed
abstract class DeleteProductRes with _$DeleteProductRes {
  const factory DeleteProductRes({@JsonKey(name: 'data') required bool data}) =
      _DeleteProductRes;

  factory DeleteProductRes.fromJson(Map<String, dynamic> json) =>
      _$DeleteProductResFromJson(json);
}

@freezed
abstract class AddProductRes with _$AddProductRes {
  const factory AddProductRes({@JsonKey(name: 'data') required int data}) =
      _AddProductRes;

  factory AddProductRes.fromJson(Map<String, dynamic> json) =>
      _$AddProductResFromJson(json);
}
