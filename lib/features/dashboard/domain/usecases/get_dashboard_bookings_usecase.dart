import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../repositories/dashboard_repository_contract.dart';

@injectable
class GetDashboardBookingsUseCase {
  final DashboardRepositoryContract _dashboardRepository;

  const GetDashboardBookingsUseCase(this._dashboardRepository);

  Future<BaseResponse<List<BookingEntity>>> call() {
    return _dashboardRepository.getBookings();
  }
}
