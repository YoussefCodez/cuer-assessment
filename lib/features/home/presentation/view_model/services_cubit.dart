import 'package:cure/features/home/domain/entities/service_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../domain/usecases/get_services_usecase.dart';
import 'services_state.dart';

@injectable
class ServicesCubit extends Cubit<ServicesState> {
  final GetServicesUseCase _getServicesUseCase;

  ServicesCubit({
    required GetServicesUseCase getServicesUseCase,
  })  : _getServicesUseCase = getServicesUseCase,
        super(const ServicesInitial());

  Future<void> loadServices() async {
    emit(const ServicesLoading());
    final result = await _getServicesUseCase();
    if (result is SuccessResponse<List<ServiceEntity>>) {
      emit(ServicesLoaded(result.data));
    } else if (result is FailedResponse<List<ServiceEntity>>) {
      emit(ServicesFailure(result.message));
    }
  }
}
