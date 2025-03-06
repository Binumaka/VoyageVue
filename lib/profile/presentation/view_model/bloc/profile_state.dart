part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final AuthEntity? currentuser;
  final String? errorMessage;

  const ProfileState({
    required this.isLoading,
    this.currentuser,
    this.errorMessage,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      isLoading: false,
      currentuser: null,
      errorMessage: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    AuthEntity? user,
    String? errorMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      currentuser: user ?? this.currentuser,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, currentuser, errorMessage];
}