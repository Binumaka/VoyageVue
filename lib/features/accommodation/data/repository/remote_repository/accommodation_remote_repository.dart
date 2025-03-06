import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/accommodation/data/data_source/remote_data_source/accommodation_remote_datasource.dart';
import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';
import 'package:voyagevue/features/accommodation/domain/repository/accommodation_repository.dart';

class AccommodationRemoteRepository implements IAccommodationRepository {
  final AccommodationRemoteDataSource _accremoteDataSource;

  AccommodationRemoteRepository(this._accremoteDataSource);

  @override
  Future<Either<Failure, List<AccommodationEntity>>>
      getAccommodationByDestination(String id) async {
    try {
      final accommodationByDestination =
          await _accremoteDataSource.getAccommodationsByDestination(id);
      return Right(accommodationByDestination);
    } on DioException catch (e) {
      return Left(ApiFailure(message: e.response?.data ?? e.message));
    } catch (e) {
      return Left(ApiFailure(message: "Unexpected Error: ${e.toString()}"));
    }
  }
}
