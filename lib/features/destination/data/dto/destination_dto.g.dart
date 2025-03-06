// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationDto _$DestinationDtoFromJson(Map<String, dynamic> json) =>
    DestinationDto(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => DestinationApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DestinationDtoToJson(DestinationDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
