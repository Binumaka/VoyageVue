import 'package:dartz/dartz.dart';
import 'package:voyagevue/app/usecase/usecase.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/domain/repository/destination_repository.dart';

class GetAllDestinationsUseCase implements UsecaseWithoutParams<List<DestinationEntity>> {
  final IDestinationRepository _destinationRepository;

  GetAllDestinationsUseCase({required IDestinationRepository destinationRepository})
      : _destinationRepository = destinationRepository;

  @override
  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _destinationRepository.getDestinations();
  }
}

