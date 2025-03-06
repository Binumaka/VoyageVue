import 'package:json_annotation/json_annotation.dart';
import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';

part 'guide_api_model.g.dart';

@JsonSerializable()
class GuideApiModel {
  final String id;
  final String name;
  final String email;
  final int experience;
  final List<String> languages;
  final int contact;
  final bool availability;

  GuideApiModel({
    required this.id,
    required this.name,
    required this.email,
    required this.experience,
    required this.languages,
    required this.contact,
    required this.availability,
  });

  // From JSON constructor
  factory GuideApiModel.fromJson(Map<String, dynamic> json) {
    return GuideApiModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      experience: json['experience'] ?? 0,
      languages: List<String>.from(json['languages'] ?? []),
      contact: json['contact'] ?? 0,
      availability: json['availability'] ?? false,
    );
  }

  // Convert to Entity
  GuideEntity toEntity() {
    return GuideEntity(
      id: id,
      name: name,
      email: email,
      experience: experience,
      languages: languages,
      contact: contact,
      availability: availability,
    );
  }

  List<Object?> get props =>
      [id, name, email, experience, languages, contact, availability];
}
