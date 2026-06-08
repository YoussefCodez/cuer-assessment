// lib/features/dashboard/presentation/widgets/dashboard_header.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/dashboard_strings.dart';

const double _titleFontSize = 24;

/// Displays the personalized welcome greeting at the top of the dashboard.
class DashboardHeader extends StatelessWidget {
  final String userName;

  const DashboardHeader({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${DashboardStrings.welcomePrefix}$userName${DashboardStrings.welcomeSuffix}',
      style: TextStyle(
        fontSize: _titleFontSize.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
}
