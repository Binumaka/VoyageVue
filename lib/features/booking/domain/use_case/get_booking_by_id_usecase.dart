import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/booking/domain/entity/booking_entity.dart';
import 'package:voyagevue/features/booking/domain/repository/booking_repository.dart';

class GetBookingByIdUsecase {
  final IBookingRepository _bookingrepository;

  GetBookingByIdUsecase(this._bookingrepository);

  Future<Either<Failure, BookingEntity>> call(String userId) async {
    return await _bookingrepository.getBookingById(userId);
  }
}


