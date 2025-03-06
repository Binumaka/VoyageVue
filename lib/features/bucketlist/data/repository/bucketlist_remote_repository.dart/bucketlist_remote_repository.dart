import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voyagevue/features/bucketlist/data/data_source/remote_data_source/bucketlist_remote_datasource.dart';
import 'package:voyagevue/features/bucketlist/domain/entity/bucketlist_entity.dart';
import 'package:voyagevue/features/bucketlist/domain/repository/Bucketlist_repository.dart';

class BucketlistRemoteRepository implements IBucketlistRepository {
  final BucketlistRemoteDatasource _remoteDatasource;

  BucketlistRemoteRepository({required BucketlistRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<void> addToBucketlist(BucketListEntity bucketlist) async {
    const url = 'http://192.168.1.70:3000/api/bucket-list/create';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': bucketlist.title,
          'image': bucketlist.image,
          'description': bucketlist.description,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add to bucketlist');
      }
    } catch (error) {
      print('Error adding to bucketlist: $error');
      rethrow;
    }
  }

  @override
  Future<void> removeFromBucketlist(String id) async {
    return await _remoteDatasource.removeFromBucketlist(id, null);
  }

  @override
  Future<List<BucketListEntity>> getBucketlist(String userId) async {
    return await _remoteDatasource.getBucketlist(userId);
  }
}
