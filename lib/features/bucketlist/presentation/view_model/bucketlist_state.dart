part of 'bucketlist_bloc.dart';

class BucketlistState extends Equatable {
  const BucketlistState();

  @override
  List<Object?> get props => [];
}

class BucketlistInitial extends BucketlistState {}

class BucketlistLoading extends BucketlistState {}

class BucketlistLoaded extends BucketlistState {
  final List<BucketListEntity> bucketlist;

  const BucketlistLoaded(this.bucketlist);

  @override
  List<Object?> get props => [bucketlist];
}

class BucketlistError extends BucketlistState {
  final String message;

  const BucketlistError(this.message);

  @override
  List<Object?> get props => [message];
}
