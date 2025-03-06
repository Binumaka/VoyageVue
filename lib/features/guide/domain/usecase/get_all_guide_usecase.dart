import 'package:dartz/dartz.dart';
import 'package:voyagevue/app/usecase/usecase.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';
import 'package:voyagevue/features/guide/domain/repository/guide_repository.dart';

class GetAllGuideUseCase implements UsecaseWithoutParams<List<GuideEntity>> {
  final IGuideRepository _guideRepository;

  GetAllGuideUseCase({required IGuideRepository guideRepository})
      : _guideRepository = guideRepository;

  @override
  Future<Either<Failure, List<GuideEntity>>> call() {
    return _guideRepository.getAllGuide();
  }
}
