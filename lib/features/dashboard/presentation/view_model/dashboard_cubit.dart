import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../booking/domain/entities/booking_status.dart';
import '../../domain/usecases/get_dashboard_bookings_usecase.dart';
import '../../domain/usecases/update_booking_status_usecase.dart';
import 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardBookingsUseCase _getDashboardBookingsUseCase;
  final UpdateBookingStatusUseCase _updateBookingStatusUseCase;

  DashboardCubit({
    required GetDashboardBookingsUseCase getDashboardBookingsUseCase,
    required UpdateBookingStatusUseCase updateBookingStatusUseCase,
  })  : _getDashboardBookingsUseCase = getDashboardBookingsUseCase,
        _updateBookingStatusUseCase = updateBookingStatusUseCase,
        super(const DashboardState.initial());

  Future<void> loadDashboard({bool showLoading = true}) async {
    if (showLoading || state is! DashboardLoaded) {
      emit(const DashboardState.loading());
    }

    final result = await _getDashboardBookingsUseCase();

    if (result is SuccessResponse<List<BookingEntity>>) {
      final bookings = result.data;

      final activeBookings = bookings
          .where(
            (booking) =>
                booking.status == BookingStatus.pending ||
                booking.status == BookingStatus.confirmed,
          )
          .toList();

      final historyBookings = bookings
          .where(
            (booking) =>
                booking.status == BookingStatus.completed ||
                booking.status == BookingStatus.cancelled,
          )
          .toList();

      emit(
        DashboardState.loaded(
          activeBookings: activeBookings,
          historyBookings: historyBookings,
          totalCount: bookings.length,
          activeCount: activeBookings.length,
          completedCount: bookings
              .where((booking) => booking.status == BookingStatus.completed)
              .length,
          updatingBookingId: null,
        ),
      );
    } else if (result is FailedResponse<List<BookingEntity>>) {
      emit(DashboardState.failure(result.message));
    }
  }

  Future<void> updateBookingStatus(String id, BookingStatus newStatus) async {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      emit(currentState.copyWith(updatingBookingId: id));
    }

    final result = await _updateBookingStatusUseCase(id, newStatus);
    
    await loadDashboard(showLoading: false);
  }
}
