import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_delete_model.freezed.dart';
part 'category_delete_model.g.dart';

@freezed
abstract class DeleteCategoryRes with _$DeleteCategoryRes {
  const factory DeleteCategoryRes({@JsonKey(name: 'data') required bool data}) =
      _DeleteCategoryRes;

  factory DeleteCategoryRes.fromJson(Map<String, dynamic> json) =>
      _$DeleteCategoryResFromJson(json);
}
