// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideApiModel _$GuideApiModelFromJson(Map<String, dynamic> json) =>
    GuideApiModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      experience: (json['experience'] as num).toInt(),
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      contact: (json['contact'] as num).toInt(),
      availability: json['availability'] as bool,
    );

Map<String, dynamic> _$GuideApiModelToJson(GuideApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'experience': instance.experience,
      'languages': instance.languages,
      'contact': instance.contact,
      'availability': instance.availability,
    };
