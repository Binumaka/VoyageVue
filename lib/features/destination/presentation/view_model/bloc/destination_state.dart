part of 'destination_bloc.dart';

class DestinationState extends Equatable {
  final bool isLoading;
  final String error;
  final List<DestinationEntity> destinations;
  final List<DestinationEntity> category;
  final List<DestinationEntity> section;
  final DestinationEntity? selectedDestination;

  const DestinationState({
    required this.isLoading,
    required this.error,
    required this.destinations,
    required this.category,
    required this.section,
    this.selectedDestination,
  });

  factory DestinationState.initial() {
    return const DestinationState(
      isLoading: false,
      error: '',
      destinations: [],
      category: [],
      section: [],
      selectedDestination: null,
    );
  }

  DestinationState copyWith({
    bool? isLoading,
    String? error,
    List<DestinationEntity>? destinations,
    List<DestinationEntity>? category,
    List<DestinationEntity>? section,
    DestinationEntity? selectedDestination,
    bool clearSelectedDestination = false,
  }) {
    return DestinationState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      destinations: destinations ?? this.destinations,
      category: category ?? this.category,
      section: section ?? this.section,
      selectedDestination: clearSelectedDestination 
          ? null 
          : selectedDestination ?? this.selectedDestination,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        destinations,
        category,
        section,
        selectedDestination,
      ];
}