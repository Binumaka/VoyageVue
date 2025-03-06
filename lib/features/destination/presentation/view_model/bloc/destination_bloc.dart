import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/domain/usecase/get_all_destination_usecase.dart';
import 'package:voyagevue/features/destination/domain/usecase/get_destiantion_by_id.dart';
import 'package:voyagevue/features/destination/domain/usecase/get_destination_by_category_usecase.dart';
import 'package:voyagevue/features/destination/domain/usecase/get_destinationbyid_usecase.dart';

part 'destination_event.dart';
part 'destination_state.dart';

class DestinationBloc extends Bloc<DestinationEvent, DestinationState> {
  final GetAllDestinationsUseCase _getAllDestinationsUseCase;
  final GetDestinationsByCategoryUseCase _getDestinationsByCategoryUseCase;
  final GetDestinationsBySectionUseCase _getDestinationsBySectionUseCase;
  final GetDestinationByIdUseCase _getDestinationByIdUseCase;

  DestinationBloc({
    required GetAllDestinationsUseCase getAllDestinationsUseCase,
    required GetDestinationsByCategoryUseCase getDestinationsByCategoryUseCase,
    required GetDestinationsBySectionUseCase getDestinationsBySectionUseCase,
    required GetDestinationByIdUseCase getDestinationByIdUseCase,
  })  : _getAllDestinationsUseCase = getAllDestinationsUseCase,
        _getDestinationsByCategoryUseCase = getDestinationsByCategoryUseCase,
        _getDestinationsBySectionUseCase = getDestinationsBySectionUseCase,
        _getDestinationByIdUseCase = getDestinationByIdUseCase,
        super(DestinationState.initial()) {
    on<LoadAllDestinationsEvent>(_onGetAllDestinations);
    on<LoadCategoryEvent>(_onLoadCategory);
    on<LoadSectionEvent>(_onLoadSection);
    on<LoadDestinationByIdEvent>(_onLoadDestinationById);
    on<ClearErrorEvent>(_onClearError);
  }

  // Added proper handler for ClearErrorEvent
  void _onClearError(ClearErrorEvent event, Emitter<DestinationState> emit) {
    emit(state.copyWith(error: ''));
  }

  /// Load all destinations
  Future<void> _onGetAllDestinations(
    LoadAllDestinationsEvent event,
    Emitter<DestinationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    print("Fetching all destinations...");

    final result = await _getAllDestinationsUseCase();
    result.fold(
      (failure) {
        print("Error fetching destinations: ${failure.message}");
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (destinations) {
        print("Successfully fetched ${destinations.length} destinations");
        emit(state.copyWith(isLoading: false, destinations: destinations));
      },
    );
  }

  /// Load destinations by category
  Future<void> _onLoadCategory(
    LoadCategoryEvent event,
    Emitter<DestinationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    print("Fetching destinations for category: ${event.category}");
    
    final result = await _getDestinationsByCategoryUseCase(event.category);
    result.fold(
      (failure) {
        print("Failed to fetch category: ${failure.message}");
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (categoryDestinations) {
        print("Successfully fetched ${categoryDestinations.length} destinations for category: ${event.category}");
        emit(state.copyWith(
          isLoading: false,
          category: categoryDestinations,
        ));
      },
    );
  }

  // Load destinations by section
  Future<void> _onLoadSection(
    LoadSectionEvent event,
    Emitter<DestinationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    print("Fetching destinations for section: ${event.section}");

    final result = await _getDestinationsBySectionUseCase(event.section);

    result.fold(
      (failure) {
        print("Failed to fetch section: ${failure.message}");
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (sectionDestinations) {
        print("Fetched ${sectionDestinations.length} destinations for section: ${event.section}");
        
        // Update the state with section data
        final updatedSectionData = List<DestinationEntity>.from(state.section);
        updatedSectionData.addAll(sectionDestinations);
        
        emit(state.copyWith(
          isLoading: false,
          section: updatedSectionData,
        ));
      },
    );
  }

  // Load a single destination by ID
  Future<void> _onLoadDestinationById(
    LoadDestinationByIdEvent event,
    Emitter<DestinationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    print("Fetching destination with ID: ${event.id}");
    
    final result = await _getDestinationByIdUseCase(event.id);
    result.fold(
      (failure) {
        print("Failed to fetch destination: ${failure.message}");
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (destination) {
        print("Successfully fetched destination: ${destination.title}");
        emit(state.copyWith(
          isLoading: false,
          selectedDestination: destination,
        ));
      },
    );
  }
}