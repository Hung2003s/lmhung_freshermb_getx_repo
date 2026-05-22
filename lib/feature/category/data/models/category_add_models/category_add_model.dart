import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_add_model.freezed.dart';
part 'category_add_model.g.dart';
@freezed
abstract class CategoryAddParams with _$CategoryAddParams{
  const factory CategoryAddParams({
    @JsonKey(name: 'name') required String name
}) = _CategoryAddParams;

  factory CategoryAddParams.fromJson(Map<String, dynamic> json) =>
      _$CategoryAddParamsFromJson(json);
}

@freezed
abstract class CategoryAddRes with _$CategoryAddRes{
  const factory CategoryAddRes({
    @JsonKey(name: 'data') required int data
  }) = _CategoryAddRes;

  factory CategoryAddRes.fromJson(Map<String, dynamic> json) =>
      _$CategoryAddResFromJson(json);
}