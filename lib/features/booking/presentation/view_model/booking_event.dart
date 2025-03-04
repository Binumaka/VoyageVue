part of 'booking_bloc.dart';

abstract class BookingEvent {}

class FetchBookings extends BookingEvent {
  final String userId;
  FetchBookings(this.userId);
}

class CreateNewBooking extends BookingEvent {
  final BookingEntity booking;
  CreateNewBooking(this.booking);
}

class CancelBooking extends BookingEvent {
  final String bookingId;
  final String userId;
  CancelBooking(this.bookingId, this.userId);
}
