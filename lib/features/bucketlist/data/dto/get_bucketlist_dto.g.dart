// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bucketlist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBucketlistDto _$GetBucketlistDtoFromJson(Map<String, dynamic> json) =>
    GetBucketlistDto(
      count: (json['count'] as num).toInt(),
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => BucketListApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBucketlistDtoToJson(GetBucketlistDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
