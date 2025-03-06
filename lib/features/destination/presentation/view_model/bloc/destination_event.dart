part of 'destination_bloc.dart';

abstract class DestinationEvent extends Equatable {
  const DestinationEvent();

  @override
  List<Object> get props => [];
}

class LoadAllDestinationsEvent extends DestinationEvent {}

class LoadCategoryEvent extends DestinationEvent {
  final String category;

  const LoadCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class LoadSectionEvent extends DestinationEvent {
  final String section;

  const LoadSectionEvent(this.section);

  @override
  List<Object> get props => [section];
}

class LoadDestinationByIdEvent extends DestinationEvent {
  final String id;

  const LoadDestinationByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ClearErrorEvent extends DestinationEvent {}