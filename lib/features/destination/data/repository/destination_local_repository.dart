import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/destination/data/data_source/local_data_source/destination_local_data_source.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/domain/repository/destination_repository.dart';

class DestinationLocalRepository implements IDestinationRepository {
  final DestinationLocalDataSource _destinationLocalDataSource;

  DestinationLocalRepository({required DestinationLocalDataSource destinationLocalDataSource})
      : _destinationLocalDataSource = destinationLocalDataSource;

  @override
  Future<Either<Failure, List<DestinationEntity>>> getDestinations() {
    try {
      return _destinationLocalDataSource.fetchDestinations().then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, DestinationEntity>> getDestinationById(id) {
    try {
      return _destinationLocalDataSource.getDestinationById(id).then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> getDestinationsByCategory(String category) async{
    try {
      final destinationByCategory = await _destinationLocalDataSource.getDestinationsByCategory(category);
      return Right(destinationByCategory);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> getDestinationsBySection(section) {
    try {
      return _destinationLocalDataSource.getDestinationsBySection(section).then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
