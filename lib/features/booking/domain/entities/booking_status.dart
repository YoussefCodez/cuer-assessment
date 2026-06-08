import 'package:hive_ce/hive.dart';

part 'booking_status.g.dart';

/// Represents the lifecycle state of a booking.
///
/// Transitions:
///   [pending] → [confirmed] → [completed]
///   [pending] → [cancelled]
///   [confirmed] → [cancelled]
@HiveType(typeId: 5)
enum BookingStatus {
  /// Booking has been submitted and is awaiting confirmation.
  @HiveField(0)
  pending,

  /// Booking has been confirmed by the service provider.
  @HiveField(1)
  confirmed,

  /// Service has been delivered and the booking is completed.
  @HiveField(2)
  completed,

  /// Booking was cancelled before completion.
  @HiveField(3)
  cancelled,
}
