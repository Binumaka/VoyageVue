import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voyagevue/app/constants/api_endpoints.dart';
import 'package:voyagevue/features/accommodation/data/data_source/remote_data_source/accommodation_remote_datasource.dart';
import 'package:voyagevue/features/accommodation/data/model/accommodation_api_model.dart';

// Mock Dio
class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late AccommodationRemoteDataSource remoteDataSource;

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = AccommodationRemoteDataSource(mockDio);
  });

  group('AccommodationRemoteDataSource Tests', () {
    const String destinationId = '123';
    final String url = "${ApiEndpoints.getAccommodationsByDestination}$destinationId";

    final mockResponseData = [
      {
        "id": "1",
        "name": "Luxury Beach Resort",
        "location": "Bali",
        "pricePerNight": 200,
        "rating": 4.5,
        "imageUrl": "beach_resort.jpg"
      },
      {
        "id": "2",
        "name": "Mountain Cabin",
        "location": "Switzerland",
        "pricePerNight": 150,
        "rating": 4.7,
        "imageUrl": "cabin.jpg"
      }
    ];

    final mockEntityList = mockResponseData
        .map((json) => AccommodationApiModel.fromJson(json).toEntity())
        .toList();

    test('should return a list of accommodations when the API call is successful', () async {
      // Arrange
      when(() => mockDio.get(url)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 200,
          data: mockResponseData,
        ),
      );

      // Act
      final result = await remoteDataSource.getAccommodationsByDestination(destinationId);

      // Assert
      expect(result, equals(mockEntityList));
      verify(() => mockDio.get(url)).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('should return a list of accommodations when response has nested "data" field', () async {
      // Arrange
      when(() => mockDio.get(url)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 200,
          data: {"data": mockResponseData},
        ),
      );

      // Act
      final result = await remoteDataSource.getAccommodationsByDestination(destinationId);

      // Assert
      expect(result, equals(mockEntityList));
      verify(() => mockDio.get(url)).called(1);
    });

    test('should throw an exception when API response is not 200', () async {
      // Arrange
      when(() => mockDio.get(url)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 404,
          statusMessage: "Not Found",
        ),
      );

      // Act
      final call = remoteDataSource.getAccommodationsByDestination(destinationId);

      // Assert
      expect(call, throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Failed to fetch accommodations'))));
      verify(() => mockDio.get(url)).called(1);
    });

    test('should throw an exception when DioException occurs', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: url),
        response: Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: "Internal Server Error",
        ),
        type: DioExceptionType.badResponse,
      );

      when(() => mockDio.get(url)).thenThrow(dioException);

      // Act
      final call = remoteDataSource.getAccommodationsByDestination(destinationId);

      // Assert
      expect(call, throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Dio Error'))));
      verify(() => mockDio.get(url)).called(1);
    });

    test('should throw an exception for unexpected errors', () async {
      // Arrange
      when(() => mockDio.get(url)).thenThrow(Exception('Unexpected Error'));

      // Act
      final call = remoteDataSource.getAccommodationsByDestination(destinationId);

      // Assert
      expect(call, throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Unexpected error'))));
      verify(() => mockDio.get(url)).called(1);
    });
  });
}
