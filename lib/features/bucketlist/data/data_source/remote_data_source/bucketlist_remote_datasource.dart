import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:voyagevue/app/constants/api_endpoints.dart';
import 'package:voyagevue/features/bucketlist/data/data_source/bucketlist_data_source.dart';
import 'package:voyagevue/features/bucketlist/data/model/bucketlist_api_model.dart';
import 'package:voyagevue/features/bucketlist/domain/entity/bucketlist_entity.dart';

class BucketlistRemoteDatasource implements IBucketlistDataSource {
  final Dio _dio;

  BucketlistRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<void> addToBucketlist(BucketListEntity wishlist) async {
    const url = 'http://192.168.1.70:3000/api/wishlist';
    try {
      final response = await _dio.post(url,
          data: json.encode({
            'title': wishlist.title,
            'description': wishlist.description,
            'image': wishlist.image,
          }));
      if (response.statusCode == 200) {
        print('Item added to wishlist');
      } else {
        throw Exception('Failed to add item to wishlist');
      }
    } catch (e) {
      throw Exception('Error adding to wishlist: $e');
    }
  }

  @override
  Future<void> removeFromBucketlist(String id, String? token) async {
    try {
      var response = await _dio.delete(
        '${ApiEndpoints.removeBucketlist}$id',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BucketListEntity>> getBucketlist(String username) async {
    try {
      var url = 'http://192.168.1.70:3000/api/bucket-list/$username';
      var response = await _dio.get(url);

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        List<dynamic> wishlistData = response.data;
        return wishlistData
            .map((item) => BucketListApiModel.fromJson(item).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception();
    }
  }
}
