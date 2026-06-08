import 'booking_status.dart';

/// Domain entity representing a booked service appointment.
///
/// Owned by the domain layer — no dependency on data models or frameworks.
class BookingEntity {
  /// Unique booking identifier.
  final String id;

  /// Name of the service booked (e.g. "Home Nursing").
  final String service;

  /// Human-readable date string for the appointment.
  final String date;

  /// Human-readable time string for the appointment.
  final String time;

  /// Optional health/medical notes from the patient.
  final String notes;

  /// Current lifecycle state of this booking.
  final BookingStatus status;

  const BookingEntity({
    this.id = '',
    required this.service,
    required this.date,
    required this.time,
    required this.notes,
    this.status = BookingStatus.pending,
  });
}
