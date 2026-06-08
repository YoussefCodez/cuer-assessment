import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../entities/service_entity.dart';
import '../repositories/home_repository.dart';

@injectable
class GetServicesUseCase {
  final HomeRepository _homeRepository;

  const GetServicesUseCase(this._homeRepository);

  Future<BaseResponse<List<ServiceEntity>>> call() {
    return _homeRepository.getServices();
  }
}
