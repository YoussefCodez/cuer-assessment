import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../features/booking/data/datasources/booking_local_datasource.dart';
import '../../features/booking/domain/repositories/booking_cache_contract.dart';

@module
abstract class AppModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  BookingCacheContract getBookingCacheContract(BookingLocalDataSource dataSource) => dataSource;
}
