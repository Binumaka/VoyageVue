import 'package:json_annotation/json_annotation.dart';
import 'package:voyagevue/features/accommodation/data/model/accommodation_api_model.dart';

part 'accommodation_dto.g.dart';

@JsonSerializable()
class AccommodationDto {
  final bool success;
  final int count;
  final List<AccommodationApiModel>data;

  AccommodationDto({
    required this.success,
    required this.count,
    required this.data,
  });

  factory AccommodationDto.fromJson(Map<String, dynamic>json) =>
  _$AccommodationDtoFromJson(json);

  Map<String,dynamic> toJson() => _$AccommodationDtoToJson(this);
}