import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/accommodation/data/data_source/remote_data_source/accommodation_remote_datasource.dart';
import 'package:voyagevue/features/accommodation/data/repository/remote_repository/accommodation_remote_repository.dart';
import 'package:voyagevue/features/accommodation/domain/repository/accommodation_repository.dart';

// Mock the data source
class MockAccommodationRemoteDataSource extends Mock
    implements AccommodationRemoteDataSource {}

void main() {
  late MockAccommodationRemoteDataSource mockRemoteDataSource;
  late IAccommodationRepository repository;

  setUp(() {
    mockRemoteDataSource = MockAccommodationRemoteDataSource();
    repository = AccommodationRemoteRepository(mockRemoteDataSource);
  });

  group('Accommodation Repository Tests', () {
    const String destinationId = '123';
    final accommodationList = [
    ];

    test('should return list of accommodations when API call is successful', () async {

      // Act
      final result = await repository.getAccommodationByDestination(destinationId);

      // Assert
      expect(result, Right(accommodationList));
      verify(() => mockRemoteDataSource.getAccommodationsByDestination(destinationId)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ApiFailure when API call fails with DioException', () async {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: 'Server Error',
        ),
      );
      when(() => mockRemoteDataSource.getAccommodationsByDestination(destinationId))
          .thenThrow(dioError);

      // Act
      final result = await repository.getAccommodationByDestination(destinationId);

      // Assert
      expect(result, Left(ApiFailure(message: 'Server Error')));
      verify(() => mockRemoteDataSource.getAccommodationsByDestination(destinationId)).called(1);
    });

    test('should return ApiFailure when an unexpected error occurs', () async {
      // Arrange
      when(() => mockRemoteDataSource.getAccommodationsByDestination(destinationId))
          .thenThrow(Exception('Unexpected Error'));

      // Act
      final result = await repository.getAccommodationByDestination(destinationId);

      // Assert
      expect(result, Left(ApiFailure(message: 'Unexpected Error: Exception: Unexpected Error')));
      verify(() => mockRemoteDataSource.getAccommodationsByDestination(destinationId)).called(1);
    });
  });
}
