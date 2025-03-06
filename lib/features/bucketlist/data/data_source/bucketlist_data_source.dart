
import 'package:voyagevue/features/bucketlist/domain/entity/bucketlist_entity.dart';

abstract interface class IBucketlistDataSource {
  Future<List<BucketListEntity>> getBucketlist(String userId);
  Future<void> removeFromBucketlist(String id, String? token);
  Future<void> addToBucketlist(BucketListEntity bucketlist);
}
