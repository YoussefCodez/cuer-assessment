import '../../../../config/network/base_response.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../booking/domain/entities/booking_status.dart';

/// Domain contract for the Dashboard repository.
///
/// Provides access to the merged set of all user bookings and supports
/// status transitions through the Pending → Confirmed → Completed/Cancelled
/// state machine.
abstract class DashboardRepositoryContract {
  /// Returns all bookings (cached + seeded mock data) as domain entities.
  Future<BaseResponse<List<BookingEntity>>> getBookings();

  /// Transitions the booking identified by [bookingId] to [newStatus].
  ///
  /// Returns the updated [BookingEntity] on success.
  Future<BaseResponse<BookingEntity>> updateBookingStatus(
    String bookingId,
    BookingStatus newStatus,
  );
}
