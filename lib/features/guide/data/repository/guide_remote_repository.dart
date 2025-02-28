import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/guide/data/data_source/remote_datasource/guide_remote_data_source.dart';
import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';
import 'package:voyagevue/features/guide/domain/repository/guide_repository.dart';

class GuideRemoteRepository implements IGuideRepository {
  final GuideRemoteDataSource _guideremoteDataSource;

  GuideRemoteRepository(this._guideremoteDataSource);

  @override
  Future<Either<Failure,List<GuideEntity>>>getAllGuide() async {
    try {
      final guides = await _guideremoteDataSource.getAllGuide();
      return Right(guides);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
