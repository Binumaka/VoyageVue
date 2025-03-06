import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
import 'package:voyagevue/app/constants/hive_table_constant.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';

// flutter packages pub run build_runner build
part 'destination_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.destinationTableId)
class DestinationHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final String image1;
  @HiveField(5)
  final String image2;
  @HiveField(6)
  final String bestTimeToVisit;
  @HiveField(7)
  final String location;
  @HiveField(8)
  final String description;
  @HiveField(9)
  final String section;

  DestinationHiveModel({
    String? id,
    required this.title,
    required this.category,
    required this.image,
    required this.image1,
    required this.image2,
    required this.bestTimeToVisit,
    required this.location,
    required this.description,
    required this.section,
  }) : id = id ?? const Uuid().v4();

  // Initial Constructor
  const DestinationHiveModel.initial()
      : id = '',
        title = '',
        category = '',
        image = '',
        image1 = '',
        image2 = '',
        bestTimeToVisit = '',
        location = '',
        description = '',
        section = '';

  // From Entity
  factory DestinationHiveModel.fromEntity(DestinationEntity entity) {
    return DestinationHiveModel(
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

  // To Entity
  DestinationEntity toEntity() {
    return DestinationEntity(
      id: id,
      title: title,
      category: category,
      image: image,
      image1: image1,
      image2: image2,
      bestTimeToVisit: bestTimeToVisit,
      location: location,
      description: description,
      section: section,
    );
  }

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
