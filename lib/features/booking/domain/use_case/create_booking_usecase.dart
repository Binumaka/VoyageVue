import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import '../entity/booking_entity.dart';
import '../repository/booking_repository.dart';

class CreateBookingUsecase{
  final IBookingRepository _bookingrepository;

  CreateBookingUsecase(this._bookingrepository);

  Future<Either<Failure, String>> call(BookingEntity booking) async {
    return await _bookingrepository.createBooking(booking);
  }
}
