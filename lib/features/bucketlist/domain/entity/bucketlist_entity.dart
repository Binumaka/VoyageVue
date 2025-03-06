import 'package:equatable/equatable.dart';

class BucketListEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String image;

  const BucketListEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        image,
        title,
      ];
}
