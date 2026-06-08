// lib/features/dashboard/presentation/widgets/booking_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../booking/domain/entities/booking_status.dart';
import '../../../../core/dashboard_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/dashboard_cubit.dart';
import '../view_model/dashboard_state.dart';

const double _cardRadius = 12;
const double _cardElevation = 2;
const double _cardPadding = 16;
const double _badgeRadius = 8;
const double _rowSpacing = 8;
const double _sectionSpacing = 12;

/// Displays a single booking with service details and a colored status badge.
class BookingCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _cardElevation,
      margin: EdgeInsets.only(bottom: _sectionSpacing.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(_cardPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    booking.service,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                _StatusBadge(status: booking.status),
              ],
            ),
            SizedBox(height: _sectionSpacing.h),
            _DetailRow(
              icon: Icons.calendar_today_outlined,
              label: DashboardStrings.dateLabel,
              value: booking.date,
            ),
            SizedBox(height: _rowSpacing.h),
            _DetailRow(
              icon: Icons.access_time_outlined,
              label: DashboardStrings.timeLabel,
              value: booking.time,
            ),
            if (booking.notes.isNotEmpty) ...[
              SizedBox(height: _rowSpacing.h),
              _DetailRow(
                icon: Icons.notes_outlined,
                label: DashboardStrings.notesLabel,
                value: booking.notes,
              ),
            ],
            if (booking.status == BookingStatus.pending ||
                booking.status == BookingStatus.confirmed) ...[
              SizedBox(height: _sectionSpacing.h),
              _ActionButtons(booking: booking),
            ],
          ],
        ),
      ),
    );
  }
}

/// Renders a colored status badge for a booking.
class _StatusBadge extends StatelessWidget {
  final BookingStatus status;

  const _StatusBadge({required this.status});

  Color get _backgroundColor {
    switch (status) {
      case BookingStatus.pending:
        return Colors.amber.shade100;
      case BookingStatus.confirmed:
        return Colors.green.shade100;
      case BookingStatus.completed:
        return Colors.blue.shade100;
      case BookingStatus.cancelled:
        return Colors.red.shade100;
    }
  }

  Color get _textColor {
    switch (status) {
      case BookingStatus.pending:
        return Colors.amber.shade800;
      case BookingStatus.confirmed:
        return Colors.green.shade800;
      case BookingStatus.completed:
        return Colors.blue.shade800;
      case BookingStatus.cancelled:
        return Colors.red.shade800;
    }
  }

  String get _label {
    switch (status) {
      case BookingStatus.pending:
        return DashboardStrings.statusPending;
      case BookingStatus.confirmed:
        return DashboardStrings.statusConfirmed;
      case BookingStatus.completed:
        return DashboardStrings.statusCompleted;
      case BookingStatus.cancelled:
        return DashboardStrings.statusCancelled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(_badgeRadius.r),
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: _textColor,
        ),
      ),
    );
  }
}

/// Renders a labeled booking detail row with an icon.
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16.r, color: AppColors.primary),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Action buttons for a booking based on its status.
class _ActionButtons extends StatelessWidget {
  final BookingEntity booking;

  const _ActionButtons({required this.booking});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        bool isLoading = false;
        if (state is DashboardLoaded && state.updatingBookingId == booking.id) {
          isLoading = true;
        }

        if (isLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              ],
            ),
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (booking.status == BookingStatus.pending ||
                booking.status == BookingStatus.confirmed)
              TextButton(
                onPressed: () {
                  context.read<DashboardCubit>().updateBookingStatus(
                    booking.id,
                    BookingStatus.cancelled,
                  );
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text(DashboardStrings.actionCancel),
              ),
            SizedBox(width: 8.w),
            if (booking.status == BookingStatus.pending)
              ElevatedButton(
                onPressed: () {
                  context.read<DashboardCubit>().updateBookingStatus(
                    booking.id,
                    BookingStatus.confirmed,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                child: Text(
                  DashboardStrings.actionConfirm,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            if (booking.status == BookingStatus.confirmed)
              ElevatedButton(
                onPressed: () {
                  context.read<DashboardCubit>().updateBookingStatus(
                    booking.id,
                    BookingStatus.completed,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                child: Text(
                  DashboardStrings.actionComplete,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
          ],
        );
      },
    );
  }
}
