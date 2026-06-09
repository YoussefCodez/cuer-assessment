import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cure/features/home/data/repositories/home_repository_impl.dart';
import 'package:cure/features/home/data/datasources/home_mock_datasource.dart';
import 'package:cure/features/home/data/datasources/home_local_datasource.dart';
import 'package:cure/features/home/data/models/service_model.dart';
import 'package:cure/config/network/base_response.dart';
import 'package:cure/config/network/network_exceptions.dart';

class MockHomeMockDataSource extends Mock implements HomeMockDataSource {}
class MockHomeLocalDataSource extends Mock implements HomeLocalDataSource {}

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeMockDataSource mockRemoteDataSource;
  late MockHomeLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeMockDataSource();
    mockLocalDataSource = MockHomeLocalDataSource();

    repository = HomeRepositoryImpl(
      homeMockDataSource: mockRemoteDataSource,
      homeLocalDataSource: mockLocalDataSource,
    );
  });

  final tServiceModel = ServiceModel(
    id: '1',
    title: 'Test Service',
    description: 'Test Description',
    iconCodePoint: 0,
    price: '100',
  );
  final tServiceModelsList = [tServiceModel];

  group('getServices', () {
    test('should return cached data when cache is not empty', () async {
      // arrange
      when(() => mockLocalDataSource.getCachedServices())
          .thenAnswer((_) async => tServiceModelsList);

      // act
      final result = await repository.getServices();

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockLocalDataSource.getCachedServices()).called(1);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('should fetch from remote and cache when cache is empty', () async {
      // arrange
      when(() => mockLocalDataSource.getCachedServices()).thenAnswer((_) async => []);
      when(() => mockRemoteDataSource.fetchServices()).thenAnswer((_) async => tServiceModelsList);
      when(() => mockLocalDataSource.cacheServices(tServiceModelsList)).thenAnswer((_) async {});

      // act
      final result = await repository.getServices();

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockLocalDataSource.getCachedServices()).called(1);
      verify(() => mockRemoteDataSource.fetchServices()).called(1);
      verify(() => mockLocalDataSource.cacheServices(tServiceModelsList)).called(1);
    });

    test('should return FailedResponse when remote throws NetworkException and cache is empty', () async {
      // arrange
      when(() => mockLocalDataSource.getCachedServices()).thenAnswer((_) async => []);
      
      when(() => mockRemoteDataSource.fetchServices()).thenThrow(const NetworkException('Error'));

      // act
      final result = await repository.getServices();

      // assert
      expect(result, isA<FailedResponse>());
      // It calls getCachedServices twice (once at start, once in catch block)
      verify(() => mockLocalDataSource.getCachedServices()).called(2);
      verify(() => mockRemoteDataSource.fetchServices()).called(1);
    });

    test('should return SuccessResponse from cache when remote throws exception but cache is not empty on fallback', () async {
      // arrange
      // First call to getCachedServices returns empty
      // Second call (in catch block) returns data (simulating a scenario or edge case)
      int callCount = 0;
      when(() => mockLocalDataSource.getCachedServices()).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) return [];
        return tServiceModelsList;
      });
      
      when(() => mockRemoteDataSource.fetchServices()).thenThrow(Exception());

      // act
      final result = await repository.getServices();

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockLocalDataSource.getCachedServices()).called(2);
      verify(() => mockRemoteDataSource.fetchServices()).called(1);
    });
  });
}
