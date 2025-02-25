part of 'accommodation_bloc.dart';

abstract class AccommodationEvent extends Equatable {
  const AccommodationEvent();

  @override
  List<Object?> get props => [];
}

class LoadAccommodationsByDestinationEvent extends AccommodationEvent {
  final String id;

  const LoadAccommodationsByDestinationEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ClearAccommodationErrorEvent extends AccommodationEvent {
  const ClearAccommodationErrorEvent();
}
