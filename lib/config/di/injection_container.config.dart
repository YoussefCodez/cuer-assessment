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
import 'package:cure/features/auth/domain/repositories/auth_repository.dart'
    as _i771;
import 'package:cure/features/auth/domain/usecases/is_logged_in_usecase.dart'
    as _i312;
import 'package:cure/features/auth/domain/usecases/login_usecase.dart' as _i147;
import 'package:cure/features/auth/domain/usecases/logout_usecase.dart'
    as _i583;
import 'package:cure/features/auth/domain/usecases/register_usecase.dart'
    as _i217;
import 'package:cure/features/auth/presentation/view_model/auth_cubit.dart'
    as _i129;
import 'package:cure/features/home/data/datasources/home_local_datasource.dart'
    as _i207;
import 'package:cure/features/home/data/datasources/home_mock_datasource.dart'
    as _i424;
import 'package:cure/features/home/data/repositories/home_repository_impl.dart'
    as _i664;
import 'package:cure/features/home/domain/repositories/home_repository.dart'
    as _i420;
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
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.lazySingleton<_i760.AuthLocalDataSource>(
      () => _i760.AuthLocalDataSource(),
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
    gh.lazySingleton<_i420.HomeRepository>(
      () => _i664.HomeRepositoryImpl(
        homeMockDataSource: gh<_i424.HomeMockDataSource>(),
        homeLocalDataSource: gh<_i207.HomeLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i329.AuthMockDataSource>(
      () => _i329.AuthMockDataSource(gh<_i438.DioClient>()),
    );
    gh.factory<_i182.GetServicesUseCase>(
      () => _i182.GetServicesUseCase(gh<_i420.HomeRepository>()),
    );
    gh.lazySingleton<_i771.AuthRepository>(
      () => _i647.AuthRepositoryImpl(
        authMockDataSource: gh<_i329.AuthMockDataSource>(),
        authLocalDataSource: gh<_i760.AuthLocalDataSource>(),
        tokenStorage: gh<_i21.TokenStorage>(),
      ),
    );
    gh.factory<_i312.IsLoggedInUseCase>(
      () => _i312.IsLoggedInUseCase(gh<_i771.AuthRepository>()),
    );
    gh.factory<_i147.LoginUseCase>(
      () => _i147.LoginUseCase(gh<_i771.AuthRepository>()),
    );
    gh.factory<_i583.LogoutUseCase>(
      () => _i583.LogoutUseCase(gh<_i771.AuthRepository>()),
    );
    gh.factory<_i217.RegisterUseCase>(
      () => _i217.RegisterUseCase(gh<_i771.AuthRepository>()),
    );
    gh.factory<_i795.ServicesCubit>(
      () => _i795.ServicesCubit(
        getServicesUseCase: gh<_i182.GetServicesUseCase>(),
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
