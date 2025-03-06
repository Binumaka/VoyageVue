import 'package:equatable/equatable.dart';

class DestinationEntity extends Equatable {
  final String? id;
  final String title;
  final String category;
  final String image;
  final String image1;
  final String image2;
  final String bestTimeToVisit;
  final String location;
  final String description;
  final String section;

  const DestinationEntity({
    this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.image1,
    required this.image2,
    required this.bestTimeToVisit,
    required this.location,
    required this.description,
    required this.section,
  });

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
