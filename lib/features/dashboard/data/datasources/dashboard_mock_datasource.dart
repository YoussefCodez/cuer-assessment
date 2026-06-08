import 'package:injectable/injectable.dart';
import '../../../booking/domain/entities/booking_status.dart';
import '../../../booking/domain/entities/booking_entity.dart';

/// Hive-persisted seed data source for the Dashboard feature.
///
/// Provides a set of pre-seeded mock bookings that are merged with
/// user-submitted bookings from the local cache on first load.
@lazySingleton
class DashboardMockDataSource {
  const DashboardMockDataSource();

  /// Returns a list of seeded mock [BookingEntity] objects.
  Future<List<BookingEntity>> fetchBookings() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    return const [
      BookingEntity(
        id: '1',
        service: 'Home Nursing',
        date: '15 June 2025',
        time: '10:00 AM',
        notes: 'Penicillin allergy',
        status: BookingStatus.confirmed,
      ),
      BookingEntity(
        id: '2',
        service: 'Blood Pressure Check',
        date: '10 June 2025',
        time: '09:00 AM',
        notes: '',
        status: BookingStatus.completed,
      ),
      BookingEntity(
        id: '3',
        service: 'Injection',
        date: '20 June 2025',
        time: '11:00 AM',
        notes: 'Insulin injection',
        status: BookingStatus.pending,
      ),
      BookingEntity(
        id: '4',
        service: 'Home Nursing',
        date: '05 June 2025',
        time: '02:00 PM',
        notes: '',
        status: BookingStatus.cancelled,
      ),
    ];
  }
}
