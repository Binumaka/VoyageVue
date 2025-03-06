import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';

abstract class IDestinationRepository {
  Future<Either<Failure, List<DestinationEntity>>> getDestinations();
  Future<Either<Failure, DestinationEntity>> getDestinationById(String id);
  Future<Either<Failure, List<DestinationEntity>>> getDestinationsByCategory(String category);
  Future<Either<Failure, List<DestinationEntity>>> getDestinationsBySection(String section);
}
