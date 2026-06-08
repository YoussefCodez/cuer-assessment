// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cure/config/di/app_module.dart' as _i759;
import 'package:cure/config/network/dio_client.dart' as _i438;
import 'package:cure/config/storage/token_storage.dart' as _i21;
import 'package:cure/features/auth/data/datasources/auth_local_datasource.dart'
    as _i760;
import 'package:cure/features/auth/data/datasources/auth_mock_datasource.dart'
    as _i329;
import 'package:cure/features/auth/data/repositories/auth_repository_impl.dart'
    as _i647;
import 'package:cure/features/auth/domain/auth_validator.dart' as _i695;
import 'package:cure/features/auth/domain/repositories/auth_repository_contract.dart'
    as _i57;
import 'package:cure/features/auth/domain/usecases/is_logged_in_usecase.dart'
    as _i312;
import 'package:cure/features/auth/domain/usecases/login_usecase.dart' as _i147;
import 'package:cure/features/auth/domain/usecases/logout_usecase.dart'
    as _i583;
import 'package:cure/features/auth/domain/usecases/register_usecase.dart'
    as _i217;
import 'package:cure/features/auth/presentation/view_model/auth_cubit.dart'
    as _i129;
import 'package:cure/features/booking/data/datasources/booking_local_datasource.dart'
    as _i427;
import 'package:cure/features/booking/data/datasources/booking_mock_remote_datasource.dart'
    as _i1063;
import 'package:cure/features/booking/data/repositories/booking_repository_impl.dart'
    as _i708;
import 'package:cure/features/booking/domain/repositories/booking_cache_contract.dart'
    as _i682;
import 'package:cure/features/booking/domain/repositories/booking_repository_contract.dart'
    as _i248;
import 'package:cure/features/booking/domain/usecases/fetch_available_times.dart'
    as _i507;
import 'package:cure/features/booking/domain/usecases/get_booking_history.dart'
    as _i338;
import 'package:cure/features/booking/domain/usecases/submit_booking_usecase.dart'
    as _i1043;
import 'package:cure/features/booking/presentation/view_model/booking_cubit.dart'
    as _i147;
import 'package:cure/features/dashboard/data/datasources/dashboard_mock_datasource.dart'
    as _i607;
import 'package:cure/features/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i21;
import 'package:cure/features/dashboard/domain/repositories/dashboard_repository_contract.dart'
    as _i754;
import 'package:cure/features/dashboard/domain/usecases/get_dashboard_bookings_usecase.dart'
    as _i944;
import 'package:cure/features/dashboard/domain/usecases/update_booking_status_usecase.dart'
    as _i613;
import 'package:cure/features/dashboard/presentation/view_model/dashboard_cubit.dart'
    as _i68;
import 'package:cure/features/home/data/datasources/home_local_datasource.dart'
    as _i207;
import 'package:cure/features/home/data/datasources/home_mock_datasource.dart'
    as _i424;
import 'package:cure/features/home/data/repositories/home_repository_impl.dart'
    as _i664;
import 'package:cure/features/home/domain/repositories/home_repository_contract.dart'
    as _i701;
import 'package:cure/features/home/domain/usecases/get_services_usecase.dart'
    as _i182;
import 'package:cure/features/home/presentation/view_model/services_cubit.dart'
    as _i795;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i695.AuthValidator>(() => const _i695.AuthValidator());
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.lazySingleton<_i760.AuthLocalDataSource>(
      () => _i760.AuthLocalDataSource(),
    );
    gh.lazySingleton<_i427.BookingLocalDataSource>(
      () => _i427.BookingLocalDataSource(),
    );
    gh.lazySingleton<_i607.DashboardMockDataSource>(
      () => const _i607.DashboardMockDataSource(),
    );
    gh.lazySingleton<_i207.HomeLocalDataSource>(
      () => _i207.HomeLocalDataSource(),
    );
    gh.lazySingleton<_i424.HomeMockDataSource>(
      () => _i424.HomeMockDataSource(),
    );
    gh.lazySingleton<_i438.DioClient>(() => _i438.DioClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i21.TokenStorage>(
      () => _i21.TokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i682.BookingCacheContract>(
      () =>
          appModule.getBookingCacheContract(gh<_i427.BookingLocalDataSource>()),
    );
    gh.lazySingleton<_i754.DashboardRepositoryContract>(
      () => _i21.DashboardRepositoryImpl(
        dashboardMockDataSource: gh<_i607.DashboardMockDataSource>(),
        bookingCacheContract: gh<_i682.BookingCacheContract>(),
      ),
    );
    gh.lazySingleton<_i701.HomeRepositoryContract>(
      () => _i664.HomeRepositoryImpl(
        homeMockDataSource: gh<_i424.HomeMockDataSource>(),
        homeLocalDataSource: gh<_i207.HomeLocalDataSource>(),
      ),
    );
    gh.factory<_i182.GetServicesUseCase>(
      () => _i182.GetServicesUseCase(gh<_i701.HomeRepositoryContract>()),
    );
    gh.lazySingleton<_i329.AuthMockDataSource>(
      () => _i329.AuthMockDataSource(gh<_i438.DioClient>()),
    );
    gh.lazySingleton<_i1063.BookingMockRemoteDataSource>(
      () => _i1063.BookingMockRemoteDataSource(gh<_i438.DioClient>()),
    );
    gh.factory<_i613.UpdateBookingStatusUseCase>(
      () => _i613.UpdateBookingStatusUseCase(
        gh<_i754.DashboardRepositoryContract>(),
      ),
    );
    gh.factory<_i795.ServicesCubit>(
      () => _i795.ServicesCubit(
        getServicesUseCase: gh<_i182.GetServicesUseCase>(),
      ),
    );
    gh.factory<_i944.GetDashboardBookingsUseCase>(
      () => _i944.GetDashboardBookingsUseCase(
        gh<_i754.DashboardRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i57.AuthRepositoryContract>(
      () => _i647.AuthRepositoryImpl(
        authMockDataSource: gh<_i329.AuthMockDataSource>(),
        authLocalDataSource: gh<_i760.AuthLocalDataSource>(),
        tokenStorage: gh<_i21.TokenStorage>(),
        authValidator: gh<_i695.AuthValidator>(),
      ),
    );
    gh.lazySingleton<_i248.BookingRepositoryContract>(
      () => _i708.BookingRepositoryImpl(
        bookingMockRemoteDataSource: gh<_i1063.BookingMockRemoteDataSource>(),
        bookingLocalDataSource: gh<_i427.BookingLocalDataSource>(),
      ),
    );
    gh.factory<_i68.DashboardCubit>(
      () => _i68.DashboardCubit(
        getDashboardBookingsUseCase: gh<_i944.GetDashboardBookingsUseCase>(),
        updateBookingStatusUseCase: gh<_i613.UpdateBookingStatusUseCase>(),
      ),
    );
    gh.lazySingleton<_i507.FetchAvailableTimesUseCase>(
      () => _i507.FetchAvailableTimesUseCase(
        gh<_i248.BookingRepositoryContract>(),
      ),
    );
    gh.lazySingleton<_i338.GetBookingHistoryUseCase>(
      () =>
          _i338.GetBookingHistoryUseCase(gh<_i248.BookingRepositoryContract>()),
    );
    gh.lazySingleton<_i1043.SubmitBookingUseCase>(
      () => _i1043.SubmitBookingUseCase(gh<_i248.BookingRepositoryContract>()),
    );
    gh.factory<_i312.IsLoggedInUseCase>(
      () => _i312.IsLoggedInUseCase(gh<_i57.AuthRepositoryContract>()),
    );
    gh.factory<_i147.LoginUseCase>(
      () => _i147.LoginUseCase(gh<_i57.AuthRepositoryContract>()),
    );
    gh.factory<_i583.LogoutUseCase>(
      () => _i583.LogoutUseCase(gh<_i57.AuthRepositoryContract>()),
    );
    gh.factory<_i217.RegisterUseCase>(
      () => _i217.RegisterUseCase(gh<_i57.AuthRepositoryContract>()),
    );
    gh.factory<_i147.BookingCubit>(
      () => _i147.BookingCubit(
        gh<_i507.FetchAvailableTimesUseCase>(),
        gh<_i1043.SubmitBookingUseCase>(),
      ),
    );
    gh.factory<_i129.AuthCubit>(
      () => _i129.AuthCubit(
        loginUseCase: gh<_i147.LoginUseCase>(),
        registerUseCase: gh<_i217.RegisterUseCase>(),
        logoutUseCase: gh<_i583.LogoutUseCase>(),
        isLoggedInUseCase: gh<_i312.IsLoggedInUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i759.AppModule {}
