import 'package:voyagevue/features/bucketlist/domain/entity/bucketlist_entity.dart';
import 'package:voyagevue/features/bucketlist/domain/repository/Bucketlist_repository.dart';

class AddToBucketlistUseCase {
  final IBucketlistRepository repository;

  AddToBucketlistUseCase(this.repository);

  Future<void> call(BucketListEntity bucketlist) async {
    await repository.addToBucketlist(bucketlist);
  }
}