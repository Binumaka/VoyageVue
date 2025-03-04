import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/booking/data/data_source/remote_datasource/booking_remote_datasource.dart';
import 'package:voyagevue/features/booking/domain/entity/booking_entity.dart';
import 'package:voyagevue/features/booking/domain/repository/booking_repository.dart';

class BookingRemoteRepository implements IBookingRepository {
  final BookingRemoteDataSource remoteDatasource;

  BookingRemoteRepository({required this.remoteDatasource});

  @override
  Future<Either<Failure, String>> createBooking(BookingEntity booking) async {
    // TODO: implement createBooking
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteBooking(String bookingId) async {
    // TODO: implement createBooking
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BookingEntity>> getBookingById(String userId) async {
    try {
    final book = await remoteDatasource.getBookingById(userId);
    return Right(book as BookingEntity);
  } on DioException catch (e) {
    return Left(ApiFailure(message: e.response?.data ?? e.message));
  } catch (e) {
    return Left(ApiFailure(message: "Unexpected Error: ${e.toString()}"));
  }
}
}
