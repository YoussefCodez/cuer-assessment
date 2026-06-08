import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_mock_datasource.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeMockDataSource _homeMockDataSource;
  final HomeLocalDataSource _homeLocalDataSource;

  const HomeRepositoryImpl({
    required HomeMockDataSource homeMockDataSource,
    required HomeLocalDataSource homeLocalDataSource,
  }) : _homeMockDataSource = homeMockDataSource,
       _homeLocalDataSource = homeLocalDataSource;

  @override
  Future<BaseResponse<List<ServiceEntity>>> getServices() async {
    try {
      final remote = await _homeMockDataSource.fetchServices();
      await _homeLocalDataSource.cacheServices(remote);

      final cached = await _homeLocalDataSource.getCachedServices();
      if (cached.isEmpty) {
        return FailedResponse('No services found');
      }
      return SuccessResponse(
        cached.map((e) => e.toEntity()).toList(),
      );
    } catch (e) {
      return FailedResponse(e.toString());
    }
  }
}
