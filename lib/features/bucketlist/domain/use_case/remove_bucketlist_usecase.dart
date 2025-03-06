import 'package:voyagevue/features/bucketlist/domain/repository/Bucketlist_repository.dart';

class RemoveFromBucketlistUseCase {
  final IBucketlistRepository repository;

  RemoveFromBucketlistUseCase(this.repository);

  Future<void> call(String bucketlistId) async {
    await repository.removeFromBucketlist(bucketlistId);
  }
}