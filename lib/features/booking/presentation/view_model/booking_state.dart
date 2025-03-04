part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final bool isLoading;
  final String error;
  final List<BookingEntity> bookings;

  const BookingState({
    required this.isLoading,
    required this.error,
    required this.bookings,
  });

  factory BookingState.initial() {
    return const BookingState(
      isLoading: false,
      error: '',
      bookings: [],
    );
  }

  BookingState copyWith({
    bool? isLoading,
    String? error,
    List<BookingEntity>? bookings,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      bookings: bookings ?? this.bookings,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        bookings,
      ];
}
