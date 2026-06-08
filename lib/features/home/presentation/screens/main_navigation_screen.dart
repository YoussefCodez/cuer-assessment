import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/home_strings.dart';
import '../../../dashboard/presentation/view_model/dashboard_cubit.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import 'home_services_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  List<Widget> get _screens => const [
    HomeServicesScreen(),
    DashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1 && _currentIndex != 1) {
            context.read<DashboardCubit>().loadDashboard();
          } else if (index == 1 && _currentIndex == 1) {
             // Already on dashboard, could trigger refresh if we wanted
             context.read<DashboardCubit>().loadDashboard();
          }
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.surface,
        selectedLabelStyle: TextStyle(fontSize: 12.sp),
        unselectedLabelStyle: TextStyle(fontSize: 12.sp),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 24.r),
            activeIcon: Icon(Icons.home, size: 24.r),
            label: HomeStrings.navHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined, size: 24.r),
            activeIcon: Icon(Icons.dashboard, size: 24.r),
            label: HomeStrings.navDashboard,
          ),
        ],
      ),
    );
  }
}
