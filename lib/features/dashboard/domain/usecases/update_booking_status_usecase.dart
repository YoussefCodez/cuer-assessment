import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../booking/domain/entities/booking_status.dart';
import '../repositories/dashboard_repository_contract.dart';

/// Use case for updating the status of an existing booking.
@injectable
class UpdateBookingStatusUseCase {
  final DashboardRepositoryContract repository;

  const UpdateBookingStatusUseCase(this.repository);

  /// Updates the booking [bookingId] to [newStatus].
  Future<BaseResponse<BookingEntity>> call(String bookingId, BookingStatus newStatus) {
    return repository.updateBookingStatus(bookingId, newStatus);
  }
}
