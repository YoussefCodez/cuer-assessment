import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_colors.dart';
import '../../../auth/presentation/view_model/auth_cubit.dart';
import '../../../auth/presentation/view_model/auth_state.dart';
import '../widgets/user_profile_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return UserProfileCard(user: state.user);
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
