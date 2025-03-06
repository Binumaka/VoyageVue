// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accommodation_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccommodationApiModel _$AccommodationApiModelFromJson(
        Map<String, dynamic> json) =>
    AccommodationApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      destination: DestinationApiModel.fromJson(
          json['destination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccommodationApiModelToJson(
        AccommodationApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
      'destination': instance.destination,
    };
