import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_category_model.freezed.dart';
part 'update_category_model.g.dart';

@freezed
abstract class UpdateCategoryParam with _$UpdateCategoryParam {
  const factory UpdateCategoryParam({
    @JsonKey(name: 'name') required String name,
  }) = _UpdateCategoryParam;

  factory UpdateCategoryParam.fromJson(Map<String, dynamic> json) =>
      _$UpdateCategoryParamFromJson(json);
}

@freezed
abstract class UpdateCategoryRes with _$UpdateCategoryRes {
  const factory UpdateCategoryRes({@JsonKey(name: 'data') required bool data}) =
      _UpdateCategoryRes;

  factory UpdateCategoryRes.fromJson(Map<String, dynamic> json) =>
      _$UpdateCategoryResFromJson(json);
}
