import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';
import 'package:voyagevue/features/accommodation/domain/usecase/get_accommodation_by_destination_usecase.dart';

part 'accommodation_event.dart';
part 'accommodation_state.dart';

class AccommodationBloc extends Bloc<AccommodationEvent, AccommodationState> {
  final GetAccommodationByDestinationUseCase
      getAccommodationByDestinationUseCase;

  AccommodationBloc({required this.getAccommodationByDestinationUseCase})
      : super(const AccommodationState()) {
    on<LoadAccommodationsByDestinationEvent>(
        _onLoadAccommodationsByDestination);
    on<ClearAccommodationErrorEvent>(_onClearError);
  }

  Future<void> _onLoadAccommodationsByDestination(
    LoadAccommodationsByDestinationEvent event,
    Emitter<AccommodationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ''));
    print("Fetching accommodation for destination: ${event.id}");

    try {
      final result = await getAccommodationByDestinationUseCase(event.id);

      result.fold(
        (failure) =>
            emit(state.copyWith(isLoading: false, error: failure.message)),
        (id) => emit(state.copyWith(
          accommodationsByDestination: id,
          isLoading: false,
          error: '', // Clear error on success
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, error: "Unexpected error: ${e.toString()}"));
    }
  }

  void _onClearError(
    ClearAccommodationErrorEvent event,
    Emitter<AccommodationState> emit,
  ) {
    emit(
        state.copyWith(error: '')); // Set error to empty string instead of null
  }
}
