import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';

abstract interface class IAccommodationDataSource {
  Future<List<AccommodationEntity>> getAccommodationsByDestination(String id);
}
