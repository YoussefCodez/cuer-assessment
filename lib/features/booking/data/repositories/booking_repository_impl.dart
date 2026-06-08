import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../../../config/network/network_exceptions.dart';
import '../../domain/entities/available_time_slot_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository_contract.dart';
import '../datasources/booking_local_datasource.dart';
import '../datasources/booking_mock_remote_datasource.dart';
import '../models/booking_model.dart';

/// Concrete implementation of [BookingRepositoryContract].
///
/// Coordinates between the mock remote data source and the local Hive cache.
@LazySingleton(as: BookingRepositoryContract)
class BookingRepositoryImpl implements BookingRepositoryContract {
  final BookingMockRemoteDataSource _bookingMockRemoteDataSource;
  final BookingLocalDataSource _bookingLocalDataSource;

  const BookingRepositoryImpl({
    required BookingMockRemoteDataSource bookingMockRemoteDataSource,
    required BookingLocalDataSource bookingLocalDataSource,
  })  : _bookingMockRemoteDataSource = bookingMockRemoteDataSource,
        _bookingLocalDataSource = bookingLocalDataSource;

  @override
  Future<BaseResponse<List<AvailableTimeSlotEntity>>> fetchAvailableTimes(
    String serviceId,
  ) async {
    try {
      final cached =
          await _bookingLocalDataSource.getCachedAvailableTimes(serviceId);
      if (cached.isNotEmpty) {
        return SuccessResponse(cached.map((e) => e.toEntity()).toList());
      }

      final remote =
          await _bookingMockRemoteDataSource.fetchAvailableTimes(serviceId);
      await _bookingLocalDataSource.cacheAvailableTimes(serviceId, remote);

      return SuccessResponse(remote.map((e) => e.toEntity()).toList());
    } on NetworkException catch (e) {
      final cached =
          await _bookingLocalDataSource.getCachedAvailableTimes(serviceId);
      if (cached.isEmpty) return FailedResponse(ErrorHandler.handle(e));
      return SuccessResponse(cached.map((e) => e.toEntity()).toList());
    } catch (e) {
      final cached =
          await _bookingLocalDataSource.getCachedAvailableTimes(serviceId);
      if (cached.isEmpty) return FailedResponse(ErrorHandler.handle(e));
      return SuccessResponse(cached.map((e) => e.toEntity()).toList());
    }
  }

  @override
  Future<BaseResponse<BookingEntity>> submitBooking(
    BookingEntity booking,
  ) async {
    try {
      final model = BookingModel(
        id: booking.id.isNotEmpty
            ? booking.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        service: booking.service,
        date: booking.date,
        time: booking.time,
        notes: booking.notes,
        status: booking.status,
      );
      final remoteModel =
          await _bookingMockRemoteDataSource.submitBooking(model);

      final entity = BookingEntity(
        id: remoteModel.id,
        service: remoteModel.service,
        date: remoteModel.date,
        time: remoteModel.time,
        notes: remoteModel.notes,
        status: remoteModel.status,
      );

      await _bookingLocalDataSource.cacheBooking(entity);
      return SuccessResponse(entity);
    } on NetworkException catch (e) {
      return FailedResponse(ErrorHandler.handle(e));
    } catch (e) {
      return FailedResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<List<BookingEntity>>> fetchBookingHistory() async {
    try {
      return SuccessResponse(
        await _bookingLocalDataSource.getCachedBookings(),
      );
    } catch (e) {
      return FailedResponse(ErrorHandler.handle(e));
    }
  }
}
