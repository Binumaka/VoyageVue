// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideDto _$GuideDtoFromJson(Map<String, dynamic> json) => GuideDto(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => GuideApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GuideDtoToJson(GuideDto instance) => <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
