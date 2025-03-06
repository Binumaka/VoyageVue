import 'package:json_annotation/json_annotation.dart';
import 'package:voyagevue/features/guide/data/model/guide_api_model.dart';

part 'guide_dto.g.dart';

@JsonSerializable()
class GuideDto {
  final bool success;
  final int count;
  final List<GuideApiModel>data;

  GuideDto({
    required this.success,
    required this.count,
    required this.data,
  });

  factory GuideDto.fromJson(Map<String, dynamic>json) =>
  _$GuideDtoFromJson(json);

  Map<String,dynamic> toJson() => _$GuideDtoToJson(this);
}