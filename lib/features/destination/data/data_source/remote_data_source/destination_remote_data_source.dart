import 'package:dio/dio.dart';
import 'package:voyagevue/app/constants/api_endpoints.dart';
import 'package:voyagevue/features/destination/data/dto/destination_dto.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/data/model/destination_api_model.dart';
import 'package:voyagevue/features/destination/data/data_source/destination_data_source.dart';

class DestinationRemoteDataSource implements IDestinationDataSource {
  final Dio _dio;
  DestinationRemoteDataSource(this._dio);

  @override
  Future<List<DestinationEntity>> fetchDestinations() async {
  try {
    var response = await _dio.get(ApiEndpoints.getAllDestinations);
    print("API Response: ${response.data}");

    if (response.statusCode == 200) {
      DestinationDto destinationDTO = DestinationDto.fromJson(response.data);
      return DestinationApiModel.toEntityList(destinationDTO.data);
    } else {
      throw Exception("Error: ${response.statusMessage}");
    }
  } on DioException catch (e) {
  print("Dio Error in getDestinationsByCategory: ${e.message}");
  throw Exception("Dio Error: ${e.message}");
} catch (e) {
  print("Unexpected Error in getDestinationsByCategory: $e");
  throw Exception("Unexpected error occurred.");
}
}

  @override
  Future<DestinationEntity> getDestinationById(String id) async {
    try {
      Response response = await _dio.get("${ApiEndpoints.getDestinationById}$id");

      if (response.statusCode == 200) {
        return DestinationApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception("Failed to fetch destination: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    }
  }

  @override
  Future<List<DestinationEntity>> getDestinationsByCategory(String category) async {
  try {
    Response response = await _dio.get("${ApiEndpoints.getDestinationsByCategory}$category");
    print("API Response: ${response.data}");

    if (response.statusCode == 200) {
      List<dynamic> data = response.data is List ? response.data : response.data['data'];
      return data.map((json) => DestinationApiModel.fromJson(json).toEntity()).toList();
    } else {
      throw Exception("Failed to fetch destinations by category: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    print("Dio Error: ${e.message}");
    throw Exception("Dio Error: ${e.message}");
  }
}


  @override
  Future<List<DestinationEntity>> getDestinationsBySection(String section) async {
    try {
      Response response = await _dio.get("${ApiEndpoints.getDestinationsBySection}$section");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => DestinationApiModel.fromJson(json).toEntity()).toList();
      } else {
        throw Exception("Failed to fetch destinations by section: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    }
  }
}
