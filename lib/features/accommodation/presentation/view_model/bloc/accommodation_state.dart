part of 'accommodation_bloc.dart';

class AccommodationState extends Equatable {
  final List<AccommodationEntity> accommodationsByDestination;
  final AccommodationEntity? selectedAccommodation;
  final bool isLoading;
  final String error;

  const AccommodationState({
    this.accommodationsByDestination = const [],
    this.selectedAccommodation,
    this.isLoading = false,
    this.error = '',
  });

  AccommodationState copyWith({
    List<AccommodationEntity>? accommodationsByDestination,
    AccommodationEntity? selectedAccommodation,
    bool? isLoading,
    String? error,
  }) {
    return AccommodationState(
      accommodationsByDestination:
          accommodationsByDestination ?? this.accommodationsByDestination,
      selectedAccommodation:
          selectedAccommodation ?? this.selectedAccommodation,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        accommodationsByDestination,
        selectedAccommodation,
        isLoading,
        error,
      ];
}
