// lib/features/dashboard/presentation/widgets/stats_summary_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/dashboard_strings.dart';

const double _cardRadius = 12;
const double _cardElevation = 2;
const double _cardVerticalPadding = 16;
const double _iconSize = 24;
const double _statValueFontSize = 20;
const double _statLabelFontSize = 12;
const double _statSpacing = 8;

/// Displays total, active, and completed booking counts in a responsive row.
class StatsSummaryCard extends StatelessWidget {
  final int total;
  final int active;
  final int completed;

  const StatsSummaryCard({
    super.key,
    required this.total,
    required this.active,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.calendar_month_outlined,
            value: total,
            label: DashboardStrings.totalBookings,
            iconColor: AppColors.primary,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _StatCard(
            icon: Icons.event_available_outlined,
            value: active,
            label: DashboardStrings.active,
            iconColor: Colors.amber.shade700,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _StatCard(
            icon: Icons.check_circle_outline,
            value: completed,
            label: DashboardStrings.completed,
            iconColor: Colors.blue.shade700,
          ),
        ),
      ],
    );
  }
}

/// Renders a single statistic card with icon, count, and label.
class _StatCard extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;
  final Color iconColor;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _cardVerticalPadding.h,
          horizontal: 8.w,
        ),
        child: Column(
          children: [
            Icon(icon, size: _iconSize.r, color: iconColor),
            SizedBox(height: _statSpacing.h),
            Text(
              '$value',
              style: TextStyle(
                fontSize: _statValueFontSize.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _statLabelFontSize.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
