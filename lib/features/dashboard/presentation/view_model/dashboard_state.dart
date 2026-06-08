import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../booking/domain/entities/booking_entity.dart';

part 'dashboard_state.freezed.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = DashboardInitial;

  const factory DashboardState.loading() = DashboardLoading;

  const factory DashboardState.loaded({
    required List<BookingEntity> activeBookings,
    required List<BookingEntity> historyBookings,
    required int totalCount,
    required int activeCount,
    required int completedCount,
    String? updatingBookingId,
  }) = DashboardLoaded;

  const factory DashboardState.failure(String message) = DashboardFailure;
}
