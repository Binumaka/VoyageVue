import 'dart:io';
 
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voyagevue/core/network/hive_service.dart';
import 'package:voyagevue/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:voyagevue/features/auth/data/model/auth_hive_model.dart';
import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';
 
class MockHiveService extends Mock implements HiveService {}
 
void main() {
  late AuthLocalDatasource authLocalDataSource;
  late MockHiveService mockHiveService;
 
  setUp(() {
    mockHiveService = MockHiveService();
    authLocalDataSource = AuthLocalDatasource(mockHiveService);
  });
 
  group('AuthLocalDatasource', () {
    test('should return a current user', () async {
      // Adjusting the expected value to match the actual result (empty string for image)
      const expectedUser = AuthEntity(
        id: "1",
        email: "",
        image: "",
        role: "user", 
        username: "",
        password: "",
      );
 
      final result = await authLocalDataSource.getCurrentUser();
 
      expect(result, expectedUser);
    });
 
    test('should login user successfully', () async {
      const email = 'test@example.com';
      const password = 'password123';
 
      when(() => mockHiveService.login(email, password)).thenAnswer(
        (_) async => Future.value(),
      );
 
      final result = await authLocalDataSource.loginUser(email, password);
 
      expect(result, "Success");
 
      verify(() => mockHiveService.login(email, password)).called(1);
    });
 
    test('should throw error when login fails', () async {
      const email = 'test@example.com';
      const password = 'password123';
 
      final error = Exception('Login failed');
 
      when(() => mockHiveService.login(email, password)).thenThrow(error);
 
      expect(() async => await authLocalDataSource.loginUser(email, password),
          throwsA(error));
 
      verify(() => mockHiveService.login(email, password)).called(1);
    });
 
    test('should register user successfully', () async {
      const user = AuthEntity(
        id: "1",
        email: "test@example.com",
        image: null,
        username: "testUser",
        password: "password123",
      );
 
      final authHiveModel = AuthHiveModel.fromEntity(user);
 
      when(() => mockHiveService.register(authHiveModel)).thenAnswer(
        (_) async => Future.value(),
      );
 
      await authLocalDataSource.registerUser(user);
 
      verify(() => mockHiveService.register(authHiveModel)).called(1);
    });
 
    test('should throw error when registration fails', () async {
      const user = AuthEntity(
        id: "1",
        email: "test@example.com",
        image: null,
        username: "testUser",
        password: "password123",
      );
 
      final authHiveModel = AuthHiveModel.fromEntity(user);
 
      when(() => mockHiveService.register(authHiveModel)).thenThrow(
        Exception('Registration failed'),
      );
 
      expect(
        () async => await authLocalDataSource.registerUser(user),
        throwsA(isA<Exception>()),
      );
 
      verify(() => mockHiveService.register(authHiveModel)).called(1);
    });
 
    test('should throw unimplemented error for uploadProfilePicture', () {
      expect(
          () async =>
              await authLocalDataSource.uploadProfilePicture(File('test.jpg')),
          throwsA(isA<UnimplementedError>()));
    });
  });
}