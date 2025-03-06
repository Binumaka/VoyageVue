import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';
import 'package:voyagevue/features/destination/data/model/destination_api_model.dart';

part 'accommodation_api_model.g.dart';

@JsonSerializable()
class AccommodationApiModel extends Equatable {  // ✅ Fixed class name
  @JsonKey(name: '_id')
  final String? id;
  final String title;
  final double price;
  final String image;
  final String description;
  final DestinationApiModel destination;

  const AccommodationApiModel({
    this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.destination,
  });

  factory AccommodationApiModel.fromJson(Map<String, dynamic> json) =>
      _$AccommodationApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccommodationApiModelToJson(this);

  // To Entity
  AccommodationEntity toEntity() {
    return AccommodationEntity(
      id: id,
      title: title,
      price: price,
      image: image,
      description: description,
      destination: destination.toEntity(),
    );
  }

  // From Entity
  factory AccommodationApiModel.fromEntity(AccommodationEntity entity) {
    return AccommodationApiModel(
      id: entity.id, // ✅ Added ID to match entity
      title: entity.title,
      price: entity.price,
      image: entity.image,
      description: entity.description,
      destination: DestinationApiModel.fromEntity(entity.destination),
    );
  }

  @override
  List<Object?> get props =>
      [id, title, price, image, description, destination];
}
