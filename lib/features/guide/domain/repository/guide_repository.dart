import 'package:dartz/dartz.dart';
import 'package:voyagevue/core/error/failure.dart';
import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';

abstract class IGuideRepository {
  // Get guide 
  Future<Either<Failure, List<GuideEntity>>> getAllGuide();
}