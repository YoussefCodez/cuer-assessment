import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'config/di/injection_container.dart';
import 'core/app_theme.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/view_model/auth_cubit.dart';
import 'features/auth/presentation/view_model/auth_state.dart';
import 'features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'features/home/presentation/screens/main_navigation_screen.dart';
import 'features/home/presentation/view_model/services_cubit.dart';
import 'hive_registrar.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>()..checkAuth(),
        ),
        BlocProvider(
          create: (context) => getIt<ServicesCubit>()..loadServices(),
        ),
        BlocProvider(
          create: (context) => getIt<DashboardCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Cure Assessment',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return const MainNavigationScreen();
                } else if (state is AuthInitial || state is AuthLoading) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const LoginScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
