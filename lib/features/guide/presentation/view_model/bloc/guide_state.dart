part of 'guide_bloc.dart';

class GuideState extends Equatable {
  final List<GuideEntity> guide;
  final bool isLoading;
  final String error;

  const GuideState({
    this.guide = const [],
    this.isLoading = false,
    this.error = '',
  });

  GuideState copyWith({
    List<GuideEntity>? guide,
    bool? isLoading,
    String? error,
  }) {
    return GuideState(
      guide: guide ?? this.guide,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [guide, isLoading, error];
}