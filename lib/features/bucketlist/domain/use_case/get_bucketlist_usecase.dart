import 'package:voyagevue/features/bucketlist/domain/entity/bucketlist_entity.dart';
import 'package:voyagevue/features/bucketlist/domain/repository/Bucketlist_repository.dart';

class GetBucketlistUseCase {
  final IBucketlistRepository repository;

  GetBucketlistUseCase(this.repository);

  Future<List<BucketListEntity>> call(String userId) async {
    return await repository.getBucketlist(userId);
  }
}
