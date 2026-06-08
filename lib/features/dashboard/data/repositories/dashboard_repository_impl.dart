import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../../../config/network/network_exceptions.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../booking/domain/entities/booking_status.dart';
import '../../../booking/domain/repositories/booking_cache_contract.dart';
import '../../domain/repositories/dashboard_repository_contract.dart';
import '../datasources/dashboard_mock_datasource.dart';

/// Concrete implementation of [DashboardRepositoryContract].
///
/// Merges seeded mock bookings with locally cached user bookings.
/// Uses [BookingCacheContract] to decouple from the booking feature's data layer.
@LazySingleton(as: DashboardRepositoryContract)
class DashboardRepositoryImpl implements DashboardRepositoryContract {
  final DashboardMockDataSource _dashboardMockDataSource;
  final BookingCacheContract _bookingCacheContract;

  const DashboardRepositoryImpl({
    required DashboardMockDataSource dashboardMockDataSource,
    required BookingCacheContract bookingCacheContract,
  })  : _dashboardMockDataSource = dashboardMockDataSource,
        _bookingCacheContract = bookingCacheContract;

  @override
  Future<BaseResponse<List<BookingEntity>>> getBookings() async {
    try {
      final cached = await _bookingCacheContract.getCachedBookings();
      final remote = await _dashboardMockDataSource.fetchBookings();
      
      // Merge remote into cache (only if not already there)
      final cachedIds = cached.map((booking) => booking.id).toSet();
      for (final booking in remote) {
        if (!cachedIds.contains(booking.id)) {
          await _bookingCacheContract.cacheBooking(booking);
        }
      }

      // Re-fetch from cache to get the final merged list
      final merged = await _bookingCacheContract.getCachedBookings();

      return SuccessResponse(merged);
    } on NetworkException catch (e) {
      final cached = await _bookingCacheContract.getCachedBookings();
      if (cached.isEmpty) {
        return FailedResponse(ErrorHandler.handle(e));
      }
      return SuccessResponse(cached);
    } catch (e) {
      final cached = await _bookingCacheContract.getCachedBookings();
      if (cached.isEmpty) {
        return FailedResponse(ErrorHandler.handle(e));
      }
      return SuccessResponse(cached);
    }
  }

  @override
  Future<BaseResponse<BookingEntity>> updateBookingStatus(
    String bookingId,
    BookingStatus newStatus,
  ) async {
    try {
      await _bookingCacheContract.updateBookingStatus(bookingId, newStatus);
      
      // Return the updated entity
      final cached = await _bookingCacheContract.getCachedBookings();
      final updated = cached.firstWhere((b) => b.id == bookingId);
      
      return SuccessResponse(updated);
    } catch (e) {
      return FailedResponse(ErrorHandler.handle(e));
    }
  }
}
