import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';

abstract class IGuideDataSource {
  Future<List<GuideEntity>> getAllGuide();
}
