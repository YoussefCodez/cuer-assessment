import 'package:cure/features/booking/domain/entities/available_time_slot_entity.dart';
import 'package:cure/features/booking/domain/entities/booking_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_states.freezed.dart';

@freezed
abstract class BookingState with _$BookingState {
  // Fetching available times states
  const factory BookingState.initial() = BookingStateInitial;
  const factory BookingState.loading() = BookingStateLoading;
  const factory BookingState.success(
    List<AvailableTimeSlotEntity> availableTimes,
  ) = BookingStateSuccess;
  const factory BookingState.failure(String error) = BookingStateFailure;

  // Submitting booking states
  const factory BookingState.submitting() = BookingStateSubmitting;
  const factory BookingState.submitted(BookingEntity booking) = BookingStateSubmitted;
  const factory BookingState.submitFailure(String error) = BookingStateSubmitFailure;
}