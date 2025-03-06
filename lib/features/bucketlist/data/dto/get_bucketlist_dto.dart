import 'package:json_annotation/json_annotation.dart';
import 'package:voyagevue/features/bucketlist/data/model/bucketlist_api_model.dart';

part 'get_bucketlist_dto.g.dart';

@JsonSerializable()
class GetBucketlistDto {
  late final bool success;
  late final int count;
  late final List<BucketListApiModel> data;

  GetBucketlistDto(
      {required this.count, required this.success, required this.data});

  Map<String, dynamic> toJson() => _$GetBucketlistDtoToJson(this);

  factory GetBucketlistDto.fromJson(Map<String, dynamic> json) =>
      _$GetBucketlistDtoFromJson(json);
}
