import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:voyagevue/features/booking/domain/use_case/delete_booking_usecase.dart';
import 'package:voyagevue/features/booking/domain/use_case/get_booking_by_id_usecase.dart';

import '../../domain/entity/booking_entity.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetBookingByIdUsecase getBookingById;
  final DeleteBookingUsecase deleteBooking;
  final CreateBookingUsecase createBooking;

  BookingBloc({
    required this.getBookingById,
    required this.deleteBooking,
    required this.createBooking,
  }) : super(BookingState.initial()) {
    on<FetchBookings>(_onGetBookingById);
    on<CreateNewBooking>(_onCreateNewBooking);
    on<CancelBooking>(_onCancelBooking);
  }

  /// Handles fetching bookings
  Future<void> _onGetBookingById(
  FetchBookings event,
  Emitter<BookingState> emit,
) async {
  emit(state.copyWith(isLoading: true, error: '')); // Show loading state

  final result = await getBookingById(event.userId);
  result.fold(
    (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message)), // Extracts failure message
    (bookings) => emit(state.copyWith(
        isLoading: false,
        bookings: List<BookingEntity>.from(bookings as Iterable))), // Ensure proper list assignment
  );
}


  /// Handles creating a new booking
  Future<void> _onCreateNewBooking(
    CreateNewBooking event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ''));

    final result = await createBooking(event.booking);
    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          error: failure.message)), // Extracts failure message
      (booking) {
        final updatedBookings = List<BookingEntity>.from(state.bookings)
          ..add(booking as BookingEntity);
        emit(state.copyWith(
            isLoading: false,
            bookings: updatedBookings)); // Emits successful booking creation
      },
    );
  }

  /// Handles deleting a booking
  Future<void> _onCancelBooking(
  CancelBooking event,
  Emitter<BookingState> emit,
) async {
  emit(state.copyWith(isLoading: true, error: ''));

  final result = await deleteBooking(event.bookingId);
  result.fold(
    (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message)), // Show error message
    (_) {
      emit(state.copyWith(isLoading: false)); // Stop loading after deletion
      Future.microtask(() => add(FetchBookings(event.userId))); // Refresh bookings
    },
  );
}

}
