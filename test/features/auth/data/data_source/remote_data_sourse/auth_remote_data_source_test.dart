import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voyagevue/app/constants/api_endpoints.dart';
import 'package:voyagevue/features/auth/data/data_source/remote_data_sourse/auth_remote_data_source.dart';
import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late AuthRemoteDataSource dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = AuthRemoteDataSource(mockDio);
  });

  group('AuthRemoteDataSource', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testToken = 'mock_token';
    final testUser = AuthEntity(
      email: testEmail,
      password: testPassword,
      username: 'TestUser',
      image: 'image.png',
      role: 'user',
    );

    test('should register user successfully', () async {
      when(() => mockDio.post(ApiEndpoints.register, data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 201,
              ));

      await dataSource.registerUser(testUser);

      verify(() => mockDio.post(ApiEndpoints.register, data: any(named: 'data')))
          .called(1);
    });

    test('should return token when login is successful', () async {
      when(() => mockDio.post(ApiEndpoints.login, data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 200,
                data: {'token': testToken},
              ));

      final result = await dataSource.loginUser(testEmail, testPassword);
      expect(result, testToken);
    });

    test('should throw an exception when login fails', () async {
      when(() => mockDio.post(ApiEndpoints.login, data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() => dataSource.loginUser(testEmail, testPassword), throwsException);
    });
  });
}
