import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_entity.freezed.dart';
part 'categories_entity.g.dart';

@freezed
abstract class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'create_at') String? createdAt,
    @JsonKey(name: 'update_at') String? updatedAt,
  }) = _CategoryEntity;
  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);
}
