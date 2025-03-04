import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';
import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';

class BookingEntity {
  final String id;
  final AuthEntity userId;
  final AccommodationEntity accommodationId;
  final DestinationEntity destinationId;
  final GuideEntity guideId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final double totalPrice;

  BookingEntity({
    required this.id,
    required this.userId,
    required this.accommodationId,
    required this.destinationId,
    required this.guideId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
  });

  List<Object?> get props => [
        id,
        userId,
        accommodationId,
        destinationId,
        guideId,
        checkInDate,
        checkOutDate,
        totalPrice
      ];
}
