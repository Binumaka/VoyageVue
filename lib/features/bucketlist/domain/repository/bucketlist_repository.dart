import 'package:voyagevue/features/bucketlist/domain/entity/bucketlist_entity.dart';

abstract interface class IBucketlistRepository {
  Future<List<BucketListEntity>> getBucketlist(String userId);
  Future<void> addToBucketlist(BucketListEntity bucketlist);
  Future<void> removeFromBucketlist(String bucketlistId);
}
