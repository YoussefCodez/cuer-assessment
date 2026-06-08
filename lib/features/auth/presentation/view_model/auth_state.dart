import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.success(UserEntity user) = AuthSuccess;
  const factory AuthState.failure(String message) = AuthFailure;
  const factory AuthState.unauthenticated() = Unauthenticated;
}
