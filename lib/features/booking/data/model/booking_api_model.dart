import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';
import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';
import 'package:voyagevue/features/booking/domain/entity/booking_entity.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';

part 'booking_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingApiModel extends Equatable {
  final String id;
  final AuthEntity userId;
  final DestinationEntity destinationId;
  final AccommodationEntity accommodationId;
  final GuideEntity guideId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final double totalPrice;

  const BookingApiModel({
    required this.id,
    required this.userId,
    required this.destinationId,
    required this.accommodationId,
    required this.guideId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
  });

  /// **Factory method for JSON deserialization**
  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  /// **Method for JSON serialization**
  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  /// **Convert API Model to Entity**
  BookingEntity toEntity() => BookingEntity(
        id: id,
        userId: userId,
        destinationId: destinationId,
        accommodationId: accommodationId,
        guideId: guideId,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        totalPrice: totalPrice,
      );

  /// **Convert Entity to API Model**
  static BookingApiModel fromEntity(BookingEntity booking) {
    return BookingApiModel(
      id: booking.id,
      userId: booking.userId,
      destinationId: booking.destinationId,
      accommodationId: booking.accommodationId,
      guideId: booking.guideId,
      checkInDate: booking.checkInDate,
      checkOutDate: booking.checkOutDate,
      totalPrice: booking.totalPrice,
    );
  }

  /// **Convert List of Models to List of Entities**
  static List<BookingEntity> toEntityList(List<BookingApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [id, userId, destinationId, accommodationId, guideId, checkInDate, checkOutDate, totalPrice];
}
