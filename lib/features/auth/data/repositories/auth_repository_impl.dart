import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../../../config/storage/token_storage.dart';
import '../../domain/auth_validator.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository_contract.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_mock_datasource.dart';

@LazySingleton(as: AuthRepositoryContract)
class AuthRepositoryImpl implements AuthRepositoryContract {
  final AuthMockDataSource _authMockDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final TokenStorage _tokenStorage;
  final AuthValidator _authValidator;

  const AuthRepositoryImpl({
    required AuthMockDataSource authMockDataSource,
    required AuthLocalDataSource authLocalDataSource,
    required TokenStorage tokenStorage,
    required AuthValidator authValidator,
  }) : _authMockDataSource = authMockDataSource,
       _authLocalDataSource = authLocalDataSource,
       _tokenStorage = tokenStorage,
       _authValidator = authValidator;

  @override
  Future<BaseResponse<UserEntity>> login(String email, String password) async {
    try {
      _authValidator.validateCredentials(email, password);

      final user = await _authMockDataSource.login(email, password);
      await _tokenStorage.saveToken(user.token);
      await _authLocalDataSource.cacheUser(user);
      return SuccessResponse(
        UserEntity(
          id: user.id,
          name: user.name,
          email: user.email,
          token: user.token,
        ),
      );
    } on ArgumentError catch (e) {
      return FailedResponse(e.message);
    } catch (e) {
      return FailedResponse(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<BaseResponse<UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (name.trim().isEmpty) {
        return FailedResponse('Name cannot be empty');
      }
      _authValidator.validateCredentials(email, password);

      final user = await _authMockDataSource.register(
        name: name,
        email: email,
        password: password,
      );
      await _tokenStorage.saveToken(user.token);
      await _authLocalDataSource.cacheUser(user);
      return SuccessResponse(
        UserEntity(
          id: user.id,
          name: user.name,
          email: user.email,
          token: user.token,
        ),
      );
    } on ArgumentError catch (e) {
      return FailedResponse(e.message);
    } catch (e) {
      return FailedResponse(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<BaseResponse<void>> logout() async {
    try {
      await _authMockDataSource.logout();
      await _tokenStorage.clearToken();
      await _authLocalDataSource.clearUser();
      return SuccessResponse(null);
    } catch (e) {
      return FailedResponse(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<BaseResponse<UserEntity>> isLoggedIn() async {
    try {
      final hasToken = await _tokenStorage.hasToken();
      if (hasToken) {
        final user = await _authLocalDataSource.getUser();
        if (user == null) {
          return FailedResponse('No user found');
        }
        return SuccessResponse(
          UserEntity(
            id: user.id,
            name: user.name,
            email: user.email,
            token: user.token,
          ),
        );
      }
      return FailedResponse('No user found');
    } catch (e) {
      return FailedResponse(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
