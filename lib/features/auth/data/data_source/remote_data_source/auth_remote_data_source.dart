import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyagevue/app/constants/api_endpoints.dart';
import 'package:voyagevue/app/shared_prefs/token_shared_prefs.dart';
import 'package:voyagevue/features/auth/data/data_source/auth_data_source.dart';
import 'package:voyagevue/features/auth/data/model/auth_api_model.dart';

import '../../../domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(ApiEndpoints.register, data: {
        "email": user.email,
        "image": user.image,
        "role": user.role,
        "username": user.username,
        "password": user.password,
        "confirmPassword": user.password
      });

      if (response.statusCode == 201) {
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
  Future<AuthEntity> getCurrentUser() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final tokenPrefs = TokenSharedPrefs(sharedPreferences);
      final tokenResult = await tokenPrefs.getToken();
      final token = tokenResult.fold(
        (failure) => throw Exception("Failed to get token: ${failure.message}"),
        (token) => token,
      );

      Response response = await _dio.get(
        ApiEndpoints.getById,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        AuthApiModel apiModel = AuthApiModel.fromJson(response.data);
        return apiModel.toEntity();
      } else {
        throw Exception(
            "Failed to get current user: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
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
  Future<void> updateUser(AuthEntity user) async {
    try {
      Response response =
          await _dio.put('${ApiEndpoints.updateById}/${user.id}', data: {
        "username": user.username,
        "email": user.email,
        "profilePicture": user.image,
      });

      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
