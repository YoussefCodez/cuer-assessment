import 'package:hive_ce/hive.dart';
import '../../domain/entities/booking_status.dart';

part 'booking_model.g.dart';

/// Hive-persisted data model for a booking.
///
/// Maps to and from [BookingEntity] in the domain layer.
@HiveType(typeId: 4)
class BookingModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String service;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String time;
  @HiveField(4)
  final String notes;
  @HiveField(5)
  final BookingStatus status;

  const BookingModel({
    required this.id,
    required this.service,
    required this.date,
    required this.time,
    required this.notes,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'service': service,
        'date': date,
        'time': time,
        'notes': notes,
        'status': status.name,
      };

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as String? ?? json['bookingId'] as String? ?? '',
        service: json['service'] as String? ?? '',
        date: json['date'] as String? ?? json['dayName'] as String? ?? '',
        time: json['time'] as String,
        notes: json['notes'] as String? ?? '',
        status: _parseStatus(json['status'] as String?),
      );

  static BookingStatus _parseStatus(String? value) {
    return BookingStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => BookingStatus.pending,
    );
  }
}
