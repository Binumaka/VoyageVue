import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:voyagevue/features/bucketlist/domain/entity/bucketlist_entity.dart';

part 'bucketlist_api_model.g.dart';

@JsonSerializable()
class BucketListApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String title;
  final String description;
  final String image;

  const BucketListApiModel({
    this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  /// Converts JSON to WishlistModel
  factory BucketListApiModel.fromJson(Map<String, dynamic> json) =>
      _$BucketListApiModelFromJson(json);

  /// Converts WishlistModel to JSON
  Map<String, dynamic> toJson() => _$BucketListApiModelToJson(this);

  /// Converts WishlistModel to WishlistEntity
  BucketListEntity toEntity() {
    return BucketListEntity(
      id: id ?? '',
      title: title,
      description: description,
      image: image,
    );
  }

  /// Converts WishlistEntity to WishlistModel
  factory BucketListApiModel.fromEntity(BucketListEntity entity) {
    return BucketListApiModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      image: entity.image,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
      ];
}
