import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';

abstract interface class IDestinationDataSource {
  Future<List<DestinationEntity>> fetchDestinations();

  Future<DestinationEntity> getDestinationById(String id);

  Future<List<DestinationEntity>> getDestinationsBySection(String section);

  Future<List<DestinationEntity>> getDestinationsByCategory(String category);
}
