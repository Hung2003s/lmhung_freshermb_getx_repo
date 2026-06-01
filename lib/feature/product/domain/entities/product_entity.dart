import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../category/domain/entities/categories_entity.dart';

part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'code') String? code,
    @JsonKey(name: 'price') required double price,
    @JsonKey(name: 'stock') required int stock,
    @JsonKey(name: 'category') CategoryEntity? category,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'image') String? image,
  }) = _ProductEntity;
}
