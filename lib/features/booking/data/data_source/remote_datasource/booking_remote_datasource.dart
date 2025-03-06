import 'package:dio/dio.dart';
import 'package:voyagevue/app/constants/api_endpoints.dart';
import 'package:voyagevue/features/booking/data/data_source/booking_data_source.dart';
import 'package:voyagevue/features/booking/data/model/booking_api_model.dart';
import 'package:voyagevue/features/booking/domain/entity/booking_entity.dart';

class BookingRemoteDataSource implements IBookingDataSource {
  final Dio _dio;

  BookingRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<void> createBooking(BookingEntity booking) async {
    try {
      var bookingApiModel = BookingApiModel.fromEntity(booking);
      var response = await _dio.post(
        ApiEndpoints.createBooking,
        data: bookingApiModel.toJson(),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to create booking: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<void> deleteBooking(String id, String? token) async {
    try {
      var response = await _dio.delete(
        ApiEndpoints.deleteBooking + id, // Fixed incorrect URL
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete booking: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<BookingEntity>> getBookingById(String userId) async {
    try {
      final url =
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getBooking.replaceFirst(':username', userId)}';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> bookingsData = response.data['bookings'];
        return bookingsData
            .map((booking) => BookingApiModel.fromJson(booking).toEntity())
            .toList();
      } else {
        throw Exception('Failed to load bookings: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
