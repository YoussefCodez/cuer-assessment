import '../entities/booking_entity.dart';
import '../entities/booking_status.dart';

/// Domain-level abstraction over the local booking cache.
///
/// Allows cross-feature consumers (e.g. Dashboard) to access persisted
/// booking data without coupling to the booking feature's data layer.
abstract class BookingCacheContract {
  /// Persists a [booking] to the local cache.
  Future<void> cacheBooking(BookingEntity booking);

  /// Returns all locally cached bookings as domain entities.
  Future<List<BookingEntity>> getCachedBookings();

  /// Updates the [newStatus] of the booking identified by [id] in the cache.
  Future<void> updateBookingStatus(String id, BookingStatus newStatus);
}
