import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/destination/data/data_source/remote_data_source/destination_remote_data_source.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/domain/repository/destination_repository.dart';

class DestinationRemoteRepository implements IDestinationRepository {
  final DestinationRemoteDataSource _remoteDataSource;

  DestinationRemoteRepository(this._remoteDataSource);

  @override
  Future<Either<Failure, List<DestinationEntity>>> getDestinations() async {
    try {
      final destinations = await _remoteDataSource.fetchDestinations();
      return Right(destinations);
    } on DioException catch (e) {
      return Left(ApiFailure(message: e.response?.data ?? e.message));
    } catch (e) {
      return Left(ApiFailure(message: "Unexpected Error: ${e.toString()}"));
    }
  }

  @override
Future<Either<Failure, DestinationEntity>> getDestinationById(String id) async {
  try {
    final destination = await _remoteDataSource.getDestinationById(id);
    return Right(destination);
  } on DioException catch (e) {
    return Left(ApiFailure(message: e.response?.data ?? e.message));
  } catch (e) {
    return Left(ApiFailure(message: "Unexpected Error: ${e.toString()}"));
  }
}

  @override
Future<Either<Failure, List<DestinationEntity>>> getDestinationsByCategory(String category) async {
  try {
    final destinationByCategory = await _remoteDataSource.getDestinationsByCategory(category);
    return Right(destinationByCategory);
  } on DioException catch (e) {
    return Left(ApiFailure(message: e.response?.data ?? e.message));
  } catch (e) {
    return Left(ApiFailure(message: "Unexpected Error: ${e.toString()}"));
  }
}


  @override
Future<Either<Failure, List<DestinationEntity>>> getDestinationsBySection(String section) async { // Explicit type
  try {
    final destinations = await _remoteDataSource.getDestinationsBySection(section);
    return Right(destinations);
  } on DioException catch (e) {
    return Left(ApiFailure(message: e.response?.data ?? e.message));
  } catch (e) {
    return Left(ApiFailure(message: "Unexpected Error: ${e.toString()}"));
  }
}
}
