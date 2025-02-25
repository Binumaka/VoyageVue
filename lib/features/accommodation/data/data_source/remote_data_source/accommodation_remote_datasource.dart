import 'package:dio/dio.dart';
import 'package:voyagevue/app/constants/api_endpoints.dart';
import 'package:voyagevue/features/accommodation/data/data_source/accommodation_datasource.dart';
import 'package:voyagevue/features/accommodation/data/model/accommodation_api_model.dart';
import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';

class AccommodationRemoteDataSource implements IAccommodationDataSource {
  final Dio _dio;

  AccommodationRemoteDataSource(this._dio);

  @override
  Future<List<AccommodationEntity>> getAccommodationsByDestination(
      String id) async {
    try {
      final String url = "${ApiEndpoints.getAccommodationsByDestination}$id";
      print("Calling API: $url");

      Response response = await _dio.get(url);
      print("API Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        // Ensure the response is valid
        final data = response.data;

        if (data is List) {
          return data
              .map((json) => AccommodationApiModel.fromJson(json).toEntity())
              .toList();
        } else if (data is Map<String, dynamic> && data.containsKey('data')) {
          return (data['data'] as List)
              .map((json) => AccommodationApiModel.fromJson(json).toEntity())
              .toList();
        } else {
          throw Exception("Unexpected API response format");
        }
      } else {
        throw Exception(
            "Failed to fetch accommodations: ${response.statusMessage} (Status Code: ${response.statusCode})");
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");

      String errorMessage = "Dio Error: ${e.message}";
      if (e.response != null) {
        errorMessage =
            "Dio Error: ${e.response?.statusCode} - ${e.response?.data}";
      }

      throw Exception(errorMessage);
    } catch (e) {
      print("Unexpected Error: ${e.toString()}");
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}
