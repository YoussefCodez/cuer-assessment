import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/service_entity.dart';

part 'services_state.freezed.dart';

@freezed
sealed class ServicesState with _$ServicesState {
  const factory ServicesState.initial() = ServicesInitial;
  const factory ServicesState.loading() = ServicesLoading;
  const factory ServicesState.loaded(List<ServiceEntity> services) =
      ServicesLoaded;
  const factory ServicesState.failure(String message) = ServicesFailure;
}
