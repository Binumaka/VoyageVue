import 'package:dartz/dartz.dart';
import 'package:voyagevue/app/usecase/usecase.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';
import 'package:voyagevue/features/accommodation/domain/repository/accommodation_repository.dart';

class GetAccommodationByDestinationUseCase implements UsecaseWithParams<List<AccommodationEntity>, String> {
  final IAccommodationRepository _accommodationRepository;

  GetAccommodationByDestinationUseCase({required IAccommodationRepository accommodationRepository})
      : _accommodationRepository = accommodationRepository;

  @override
  Future<Either<Failure, List<AccommodationEntity>>> call(String id) {
    return _accommodationRepository.getAccommodationByDestination(id);
  }
}

