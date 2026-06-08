// lib/features/dashboard/presentation/widgets/history_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../../core/dashboard_strings.dart';
import 'booking_card.dart';
import 'empty_state_widget.dart';

const double _titleFontSize = 18;
const double _titleBottomSpacing = 12;

/// Displays the booking history section with a list of past booking cards.
class HistorySection extends StatelessWidget {
  final List<BookingEntity> bookings;

  const HistorySection({
    super.key,
    required this.bookings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DashboardStrings.historyTitle,
          style: TextStyle(
            fontSize: _titleFontSize.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: _titleBottomSpacing.h),
        if (bookings.isEmpty)
          const EmptyStateWidget(
            message: DashboardStrings.noHistory,
            icon: Icons.history_outlined,
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              return BookingCard(booking: bookings[index]);
            },
          ),
      ],
    );
  }
}
