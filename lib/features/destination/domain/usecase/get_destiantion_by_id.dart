import 'package:dartz/dartz.dart';
import 'package:voyagevue/app/usecase/usecase.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/domain/repository/destination_repository.dart';

class GetDestinationByIdUseCase implements UsecaseWithParams<DestinationEntity, String> {
  final IDestinationRepository _destinationRepository;

  GetDestinationByIdUseCase({required IDestinationRepository destinationRepository})
      : _destinationRepository = destinationRepository;

  @override
  Future<Either<Failure, DestinationEntity>> call(String id) {
    return _destinationRepository.getDestinationById(id);
  }
}

