part of 'bucketlist_bloc.dart';

@immutable
sealed class BucketlistEvent extends Equatable {
  const BucketlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadBucketlist extends BucketlistEvent {
  final String userId;

  const LoadBucketlist(this.userId);

  @override
  List<Object?> get props => [userId];
}

class RemoveFromBucketlist extends BucketlistEvent {
  final String id;

  const RemoveFromBucketlist(this.id);

  @override
  List<Object?> get props => [id];
}

class AddToBucketlist extends BucketlistEvent {
  final String title;
  final String image;

  const AddToBucketlist({
    required this.title,
    required this.image,
  });

  @override
  List<Object?> get props =>
      [title, image, ];
}
