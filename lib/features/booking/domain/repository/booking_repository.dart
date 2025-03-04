import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/booking/domain/entity/booking_entity.dart';

abstract interface class IBookingRepository {
  Future<Either<Failure,String>> createBooking(BookingEntity booking);
  Future<Either<Failure, BookingEntity>> getBookingById(String userId);
  Future<Either<Failure, void>> deleteBooking(String bookingId);
}
