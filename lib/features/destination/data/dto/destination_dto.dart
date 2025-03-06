import 'package:json_annotation/json_annotation.dart';
import 'package:voyagevue/features/destination/data/model/destination_api_model.dart';

part 'destination_dto.g.dart';

@JsonSerializable()
class DestinationDto {
  final bool success;
  final int count;
  final List<DestinationApiModel>data;

  DestinationDto({
    required this.success,
    required this.count,
    required this.data,
  });

  factory DestinationDto.fromJson(Map<String, dynamic>json) =>
  _$DestinationDtoFromJson(json);

  Map<String,dynamic> toJson() => _$DestinationDtoToJson(this);
}