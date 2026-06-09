import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cure/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cure/features/auth/data/datasources/auth_mock_datasource.dart';
import 'package:cure/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:cure/config/storage/token_storage.dart';
import 'package:cure/features/auth/domain/auth_validator.dart';
import 'package:cure/features/auth/data/models/user_model.dart';
import 'package:cure/config/network/base_response.dart';

class MockAuthMockDataSource extends Mock implements AuthMockDataSource {}
class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}
class MockTokenStorage extends Mock implements TokenStorage {}
class MockAuthValidator extends Mock implements AuthValidator {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthMockDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockTokenStorage mockTokenStorage;
  late MockAuthValidator mockAuthValidator;

  setUp(() {
    mockRemoteDataSource = MockAuthMockDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    mockTokenStorage = MockTokenStorage();
    mockAuthValidator = MockAuthValidator();

    repository = AuthRepositoryImpl(
      authMockDataSource: mockRemoteDataSource,
      authLocalDataSource: mockLocalDataSource,
      tokenStorage: mockTokenStorage,
      authValidator: mockAuthValidator,
    );
  });

  const tEmail = 'test@test.com';
  const tPassword = 'Password123!';
  const tName = 'Test User';
  const tToken = 'some_random_token';
  const tUserModel = UserModel(
    id: '1',
    name: tName,
    email: tEmail,
    token: tToken,
  );

  group('login', () {
    test('should return SuccessResponse and cache token/user when login is successful', () async {
      // arrange
      when(() => mockAuthValidator.validateCredentials(tEmail, tPassword)).thenAnswer((_) {});
      when(() => mockRemoteDataSource.login(tEmail, tPassword)).thenAnswer((_) async => tUserModel);
      when(() => mockTokenStorage.saveToken(tToken)).thenAnswer((_) async {});
      when(() => mockLocalDataSource.cacheUser(tUserModel)).thenAnswer((_) async {});

      // act
      final result = await repository.login(tEmail, tPassword);

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockAuthValidator.validateCredentials(tEmail, tPassword)).called(1);
      verify(() => mockRemoteDataSource.login(tEmail, tPassword)).called(1);
      verify(() => mockTokenStorage.saveToken(tToken)).called(1);
      verify(() => mockLocalDataSource.cacheUser(tUserModel)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return FailedResponse when validation fails', () async {
      // arrange
      when(() => mockAuthValidator.validateCredentials(tEmail, tPassword))
          .thenThrow(ArgumentError('Invalid email'));

      // act
      final result = await repository.login(tEmail, tPassword);

      // assert
      expect(result, isA<FailedResponse>());
      expect((result as FailedResponse).message, 'Invalid email');
      verify(() => mockAuthValidator.validateCredentials(tEmail, tPassword)).called(1);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockTokenStorage);
      verifyZeroInteractions(mockLocalDataSource);
    });
  });

  group('register', () {
    test('should return SuccessResponse and cache token/user when register is successful', () async {
      // arrange
      when(() => mockAuthValidator.validateCredentials(tEmail, tPassword)).thenAnswer((_) {});
      when(() => mockRemoteDataSource.register(name: tName, email: tEmail, password: tPassword))
          .thenAnswer((_) async => tUserModel);
      when(() => mockTokenStorage.saveToken(tToken)).thenAnswer((_) async {});
      when(() => mockLocalDataSource.cacheUser(tUserModel)).thenAnswer((_) async {});

      // act
      final result = await repository.register(name: tName, email: tEmail, password: tPassword);

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockAuthValidator.validateCredentials(tEmail, tPassword)).called(1);
      verify(() => mockRemoteDataSource.register(name: tName, email: tEmail, password: tPassword)).called(1);
      verify(() => mockTokenStorage.saveToken(tToken)).called(1);
      verify(() => mockLocalDataSource.cacheUser(tUserModel)).called(1);
    });

    test('should return FailedResponse when name is empty', () async {
      // act
      final result = await repository.register(name: '   ', email: tEmail, password: tPassword);

      // assert
      expect(result, isA<FailedResponse>());
      expect((result as FailedResponse).message, 'Name cannot be empty');
      verifyZeroInteractions(mockAuthValidator);
      verifyZeroInteractions(mockRemoteDataSource);
    });
  });

  group('logout', () {
    test('should clear data and return SuccessResponse', () async {
      // arrange
      when(() => mockRemoteDataSource.logout()).thenAnswer((_) async {});
      when(() => mockTokenStorage.clearToken()).thenAnswer((_) async {});
      when(() => mockLocalDataSource.clearUser()).thenAnswer((_) async {});

      // act
      final result = await repository.logout();

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockRemoteDataSource.logout()).called(1);
      verify(() => mockTokenStorage.clearToken()).called(1);
      verify(() => mockLocalDataSource.clearUser()).called(1);
    });
  });

  group('isLoggedIn', () {
    test('should return SuccessResponse with user when token and user exist', () async {
      // arrange
      when(() => mockTokenStorage.hasToken()).thenAnswer((_) async => true);
      when(() => mockLocalDataSource.getUser()).thenAnswer((_) async => tUserModel);

      // act
      final result = await repository.isLoggedIn();

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockTokenStorage.hasToken()).called(1);
      verify(() => mockLocalDataSource.getUser()).called(1);
    });

    test('should return FailedResponse when token does not exist', () async {
      // arrange
      when(() => mockTokenStorage.hasToken()).thenAnswer((_) async => false);

      // act
      final result = await repository.isLoggedIn();

      // assert
      expect(result, isA<FailedResponse>());
      verify(() => mockTokenStorage.hasToken()).called(1);
      verifyNever(() => mockLocalDataSource.getUser());
    });
  });
}
