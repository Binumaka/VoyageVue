import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';

abstract class IAccommodationRepository {
  // Get accommodations by destination
  Future<Either<Failure, List<AccommodationEntity>>> getAccommodationByDestination(String id);
}