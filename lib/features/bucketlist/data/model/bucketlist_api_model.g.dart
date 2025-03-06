// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucketlist_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BucketListApiModel _$BucketListApiModelFromJson(Map<String, dynamic> json) =>
    BucketListApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$BucketListApiModelToJson(BucketListApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
    };
