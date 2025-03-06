import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';
import 'package:voyagevue/profile/domain/usecase/get_current_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  ProfileBloc({
    required GetCurrentUserUseCase getCurrentUserUseCase,
  })  : _getCurrentUserUseCase = getCurrentUserUseCase,
        super(ProfileState.initial()) {
    on<GetCurrentUser>(_onGetCurrentUser);
  }

  void _onGetCurrentUser(
    GetCurrentUser event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getCurrentUserUseCase();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (currentuser) => emit(state.copyWith(
          isLoading: false, user: currentuser, errorMessage: null)),
    );
  }
}
