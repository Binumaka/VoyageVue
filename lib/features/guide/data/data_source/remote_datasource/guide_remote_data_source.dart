import 'package:dio/dio.dart';
import 'package:voyagevue/app/constants/api_endpoints.dart';
import 'package:voyagevue/features/guide/data/data_source/guide_datasource.dart';
import 'package:voyagevue/features/guide/data/model/guide_api_model.dart';
import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';

class GuideRemoteDataSource implements IGuideDataSource {
  final Dio _dio;

  GuideRemoteDataSource(this._dio);

  @override
  Future<List<GuideEntity>> getAllGuide() async {
    try {
      final response = await _dio.get(ApiEndpoints.getAllGuide);

      if (response.statusCode == 200) {
        final data = response.data;

        // Check if data is a List
        if (data is! List) {
          throw Exception('Unexpected response format');
        }

        // Convert List of dynamic to List of GuideApiModel
        final List<GuideApiModel> guideModels = data
            .map<GuideApiModel>((item) => GuideApiModel.fromJson(item))
            .toList();

        // Convert GuideApiModel to GuideEntity
        return guideModels.map((model) => model.toEntity()).toList();
      } else {
        throw Exception('Failed to load guides: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
