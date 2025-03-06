import 'package:dartz/dartz.dart';
import 'package:voyagevue/app/usecase/usecase.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/domain/repository/destination_repository.dart';

class GetDestinationsByCategoryUseCase implements UsecaseWithParams<List<DestinationEntity>, String> {
  final IDestinationRepository _destinationRepository;

  GetDestinationsByCategoryUseCase({required IDestinationRepository destinationRepository})
      : _destinationRepository = destinationRepository;

  @override
  Future<Either<Failure, List<DestinationEntity>>> call(String category) {
    return _destinationRepository.getDestinationsByCategory(category);
  }
}

