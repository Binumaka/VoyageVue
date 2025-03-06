// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<String, dynamic> json) =>
    BookingApiModel(
      id: json['id'] as String,
      userId: json['userId'] ,
      destinationId: json['destinationId'],
      accommodationId: json['accommodationId'],
      guideId: json['guideId'],
      checkInDate: DateTime.parse(json['checkInDate'] as String),
      checkOutDate: DateTime.parse(json['checkOutDate'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'destinationId': instance.destinationId,
      'accommodationId': instance.accommodationId,
      'guideId': instance.guideId,
      'checkInDate': instance.checkInDate.toIso8601String(),
      'checkOutDate': instance.checkOutDate.toIso8601String(),
      'totalPrice': instance.totalPrice,
    };

