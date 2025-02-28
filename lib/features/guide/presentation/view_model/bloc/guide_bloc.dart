import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';
import 'package:voyagevue/features/guide/domain/usecase/get_all_guide_usecase.dart';

part 'guide_event.dart';
part 'guide_state.dart';

class GuideBloc extends Bloc<GuideEvent, GuideState> {
  final GetAllGuideUseCase getAllGuideUseCase;

  GuideBloc({required this.getAllGuideUseCase}) : super(const GuideState()) {
    on<LoadAllGuideEvent>(_onLoadAllGuide);
  }

  Future<void> _onLoadAllGuide(
    LoadAllGuideEvent event,
    Emitter<GuideState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ''));

    try {
      final result = await getAllGuideUseCase();

      result.fold((failure) => emit(state.copyWith(
          isLoading: false,
          error: failure.message,
        )),(guides) => emit(state.copyWith(
          guide: guides,
          isLoading: false,
          error: '',
        )),
      );
    } catch (e, stackTrace) {
      debugPrint("GuideBloc Error: $e\n$stackTrace");
      emit(state.copyWith(
        isLoading: false,
        error: "Unexpected error occurred. Please try again.",
      ));
    }
  }
}
