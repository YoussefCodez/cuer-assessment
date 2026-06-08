import 'package:cure/core/dashboard_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../../../auth/presentation/view_model/auth_cubit.dart';
import '../../../auth/presentation/view_model/auth_state.dart';
import '../view_model/dashboard_cubit.dart';
import '../view_model/dashboard_state.dart';
import '../widgets/active_bookings_section.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/history_section.dart';
import '../widgets/stats_summary_card.dart';

const double _horizontalPadding = 24.0;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _resolveUserName(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    if (authState is AuthSuccess) {
      return authState.user.name;
    }
    return DashboardStrings.defaultUserName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return switch (state) {
              DashboardInitial() ||
              DashboardLoading() =>
                const Center(child: CircularProgressIndicator()),
              DashboardLoaded(
                :final activeBookings,
                :final historyBookings,
                :final totalCount,
                :final activeCount,
                :final completedCount,
              ) =>
                RefreshIndicator(
                  onRefresh: () => context.read<DashboardCubit>().loadDashboard(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(_horizontalPadding.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DashboardHeader(userName: _resolveUserName(context)),
                        SizedBox(height: 24.h),
                        StatsSummaryCard(
                          total: totalCount,
                          active: activeCount,
                          completed: completedCount,
                        ),
                        SizedBox(height: 24.h),
                        ActiveBookingsSection(bookings: activeBookings),
                        SizedBox(height: 24.h),
                        HistorySection(bookings: historyBookings),
                      ],
                    ),
                  ),
                ),
              DashboardFailure(:final message) => Center(
                child: Padding(
                  padding: EdgeInsets.all(_horizontalPadding.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.error,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<DashboardCubit>().loadDashboard(),
                        child: Text(DashboardStrings.retryButton),
                      ),
                    ],
                  ),
                ),
              ),
            };
          },
        ),
      ),
    );
  }
}
