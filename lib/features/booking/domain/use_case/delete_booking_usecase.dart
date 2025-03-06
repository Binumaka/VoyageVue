import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/booking/domain/repository/booking_repository.dart';

class DeleteBookingUsecase{
  final IBookingRepository _bookingrepository;

  DeleteBookingUsecase(this._bookingrepository);

  Future<Either<Failure, void>> call(String bookingId) async {
    return await _bookingrepository.deleteBooking(bookingId);
  }
}

