// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accommodation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccommodationDto _$AccommodationDtoFromJson(Map<String, dynamic> json) =>
    AccommodationDto(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => AccommodationApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccommodationDtoToJson(AccommodationDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
