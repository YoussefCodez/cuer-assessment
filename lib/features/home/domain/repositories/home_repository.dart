import '../../../../config/network/base_response.dart';
import '../../domain/entities/service_entity.dart';

abstract class HomeRepository {
  Future<BaseResponse<List<ServiceEntity>>> getServices();
}
