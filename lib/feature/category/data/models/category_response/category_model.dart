import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/categories_entity.dart';

part 'category_model.freezed.dart';

part 'category_model.g.dart';

@freezed
abstract class CategoryResponse with _$CategoryResponse {
  const CategoryResponse._();

  const factory CategoryResponse({
    @JsonKey(name: 'data') required List<CategoryModel> data,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  List<CategoryEntity> responseToListEntities() {
    return data.map((model) => model.modelToEntity()).toList();
  }
}

@freezed
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'create_at') String? createdAt,
    @JsonKey(name: 'update_at') String? updatedAt,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  CategoryEntity modelToEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
