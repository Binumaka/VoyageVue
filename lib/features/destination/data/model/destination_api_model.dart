import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';

part 'destination_api_model.g.dart';

@JsonSerializable()
class DestinationApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? category;
  final String? image;
  final String? image1;
  final String? image2;
  final String? bestTimeToVisit;
  final String? location;
  final String? description;
  final String? section;

  const DestinationApiModel({
    this.id,
    this.title,
    this.category,
    this.image,
    this.image1,
    this.image2,
    this.bestTimeToVisit,
    this.location,
    this.description,
    this.section,
  });

  const DestinationApiModel.empty()
      : id = '',
        title = '',
        category = '',
        image = '',
        image1 = '', 
        image2 = '',
        description = '',
        section = '',
        bestTimeToVisit = '',
        location = '';

  factory DestinationApiModel.fromJson(Map<String, dynamic> json) {
    return DestinationApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      section: json['section']?.toString(),
      location: json['location'] as String?,
      bestTimeToVisit: json['bestTimeToVisit'] as String?,
      image1: json['image1'] as String?,
      image2: json['image2'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$DestinationApiModelToJson(this);

  // To Entity
  DestinationEntity toEntity() {
    return DestinationEntity(
      id: id,
      title: title ?? '',
      category: category ?? '',
      image: image ??'',
      image1: image1 ?? '',
      image2: image2 ?? '',
      bestTimeToVisit: bestTimeToVisit ?? '',
      location: location ?? '',
      description: description ?? '',
      section: section ?? '',
    );
  }

  // From Entity
  factory DestinationApiModel.fromEntity(DestinationEntity entity) {
    return DestinationApiModel(
      id: entity.id,
      title: entity.title,
      category: entity.category,
      image: entity.image,
      image1: entity.image1,
      image2: entity.image2,
      bestTimeToVisit: entity.bestTimeToVisit,
      location: entity.location,
      description: entity.description,
      section: entity.section,
    );
  }

  static List<DestinationEntity> toEntityList(List<DestinationApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        image,
        image1,
        image2,
        bestTimeToVisit,
        location,
        description,
        section,
      ];
}