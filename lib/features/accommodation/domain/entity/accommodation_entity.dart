import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';

class AccommodationEntity {
  final String? id;
  final String title;
  final double price;
  final String image;
  final String description;
  final DestinationEntity destination;

  AccommodationEntity({
    this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.destination,
  });
  List<Object?> get props =>
  [id, title, price, image, description, destination];
}
