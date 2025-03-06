import 'package:voyagevue/core/network/hive_service.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/data/data_source/destination_data_source.dart';

class DestinationLocalDataSource implements IDestinationDataSource {
  final HiveService _hiveService;

  DestinationLocalDataSource(this._hiveService);

  @override
  Future<List<DestinationEntity>> fetchDestinations() async {
    try {
      final destinations = await _hiveService.getDestinations();
      return destinations.map((e) => e.toEntity()).toList();
    } catch (e) {
       throw Exception('Failed to load destination from local storage');
    }
  }

  @override
  Future<DestinationEntity> getDestinationById(id) async {
    try {
      final destination = await _hiveService.getDestinationById(id);
      return destination!.toEntity();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<DestinationEntity>> getDestinationsBySection(String section) async {
    try {
      final destinations = await _hiveService.getDestinationsBySection(section);
      return destinations.map((e) => e.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<DestinationEntity>> getDestinationsByCategory(String category) async {
    try {
      final destinations = await _hiveService.getDestinationsByCategory(category);
      return destinations.map((e) => e.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}
