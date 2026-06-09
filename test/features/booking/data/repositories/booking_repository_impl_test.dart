import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cure/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:cure/features/booking/data/datasources/booking_mock_remote_datasource.dart';
import 'package:cure/features/booking/data/datasources/booking_local_datasource.dart';
import 'package:cure/features/booking/data/models/available_time_slot_model.dart';
import 'package:cure/features/booking/data/models/booking_model.dart';
import 'package:cure/features/booking/domain/entities/booking_entity.dart';
import 'package:cure/features/booking/domain/entities/booking_status.dart';
import 'package:cure/config/network/base_response.dart';
import 'package:cure/config/network/network_exceptions.dart';

class MockBookingMockRemoteDataSource extends Mock implements BookingMockRemoteDataSource {}
class MockBookingLocalDataSource extends Mock implements BookingLocalDataSource {}
class FakeBookingModel extends Fake implements BookingModel {}
class FakeBookingEntity extends Fake implements BookingEntity {}

void main() {
  late BookingRepositoryImpl repository;
  late MockBookingMockRemoteDataSource mockRemoteDataSource;
  late MockBookingLocalDataSource mockLocalDataSource;

  setUpAll(() {
    registerFallbackValue(FakeBookingModel());
    registerFallbackValue(FakeBookingEntity());
  });

  setUp(() {
    mockRemoteDataSource = MockBookingMockRemoteDataSource();
    mockLocalDataSource = MockBookingLocalDataSource();

    repository = BookingRepositoryImpl(
      bookingMockRemoteDataSource: mockRemoteDataSource,
      bookingLocalDataSource: mockLocalDataSource,
    );
  });

  final tServiceId = '1';
  final tAvailableTimeSlotModel = AvailableTimeSlotModel(
    dayName: 'Monday',
    times: ['10:00 AM', '11:00 AM'],
  );
  final tAvailableTimeSlotsList = [tAvailableTimeSlotModel];

  group('fetchAvailableTimes', () {
    test('should return cached data when cache is not empty', () async {
      // arrange
      when(() => mockLocalDataSource.getCachedAvailableTimes(tServiceId))
          .thenAnswer((_) async => tAvailableTimeSlotsList);

      // act
      final result = await repository.fetchAvailableTimes(tServiceId);

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockLocalDataSource.getCachedAvailableTimes(tServiceId)).called(1);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('should fetch from remote and cache when cache is empty', () async {
      // arrange
      when(() => mockLocalDataSource.getCachedAvailableTimes(tServiceId)).thenAnswer((_) async => []);
      when(() => mockRemoteDataSource.fetchAvailableTimes(tServiceId)).thenAnswer((_) async => tAvailableTimeSlotsList);
      when(() => mockLocalDataSource.cacheAvailableTimes(tServiceId, tAvailableTimeSlotsList)).thenAnswer((_) async {});

      // act
      final result = await repository.fetchAvailableTimes(tServiceId);

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockLocalDataSource.getCachedAvailableTimes(tServiceId)).called(1);
      verify(() => mockRemoteDataSource.fetchAvailableTimes(tServiceId)).called(1);
      verify(() => mockLocalDataSource.cacheAvailableTimes(tServiceId, tAvailableTimeSlotsList)).called(1);
    });

    test('should return FailedResponse when remote throws NetworkException and cache is empty', () async {
      // arrange
      when(() => mockLocalDataSource.getCachedAvailableTimes(tServiceId)).thenAnswer((_) async => []);
      
      when(() => mockRemoteDataSource.fetchAvailableTimes(tServiceId)).thenThrow(const NetworkException('Error'));

      // act
      final result = await repository.fetchAvailableTimes(tServiceId);

      // assert
      expect(result, isA<FailedResponse>());
      verify(() => mockLocalDataSource.getCachedAvailableTimes(tServiceId)).called(2);
      verify(() => mockRemoteDataSource.fetchAvailableTimes(tServiceId)).called(1);
    });
  });

  group('submitBooking', () {
    final tBookingEntity = BookingEntity(
      id: '1',
      service: 'Test Service',
      date: 'Monday',
      time: '10:00 AM',
      notes: 'Test Notes',
      status: BookingStatus.pending,
    );
    final tBookingModel = BookingModel(
      id: '1',
      service: 'Test Service',
      date: 'Monday',
      time: '10:00 AM',
      notes: 'Test Notes',
      status: BookingStatus.pending,
    );

    test('should submit booking and cache the result locally', () async {
      // arrange
      when(() => mockRemoteDataSource.submitBooking(any())).thenAnswer((_) async => tBookingModel);
      when(() => mockLocalDataSource.cacheBooking(any())).thenAnswer((_) async {});

      // act
      final result = await repository.submitBooking(tBookingEntity);

      // assert
      expect(result, isA<SuccessResponse>());
      verify(() => mockRemoteDataSource.submitBooking(any())).called(1);
      verify(() => mockLocalDataSource.cacheBooking(any())).called(1);
    });

    test('should return FailedResponse on NetworkException', () async {
      // arrange
      when(() => mockRemoteDataSource.submitBooking(any())).thenThrow(const NetworkException('Error'));

      // act
      final result = await repository.submitBooking(tBookingEntity);

      // assert
      expect(result, isA<FailedResponse>());
      verify(() => mockRemoteDataSource.submitBooking(any())).called(1);
      verifyNever(() => mockLocalDataSource.cacheBooking(any()));
    });
  });

  group('fetchBookingHistory', () {
    final tBookingEntity = BookingEntity(
      id: '1',
      service: 'Test Service',
      date: 'Monday',
      time: '10:00 AM',
      notes: 'Test Notes',
      status: BookingStatus.pending,
    );
    test('should return list of cached bookings', () async {
      // arrange
      when(() => mockLocalDataSource.getCachedBookings()).thenAnswer((_) async => [tBookingEntity]);

      // act
      final result = await repository.fetchBookingHistory();

      // assert
      expect(result, isA<SuccessResponse>());
      expect((result as SuccessResponse).data, [tBookingEntity]);
      verify(() => mockLocalDataSource.getCachedBookings()).called(1);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('should return FailedResponse when cache throws', () async {
      // arrange
      when(() => mockLocalDataSource.getCachedBookings()).thenThrow(Exception());

      // act
      final result = await repository.fetchBookingHistory();

      // assert
      expect(result, isA<FailedResponse>());
      verify(() => mockLocalDataSource.getCachedBookings()).called(1);
    });
  });
}
