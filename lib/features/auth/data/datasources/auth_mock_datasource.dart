import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/network/dio_client.dart';
import '../../../../config/network/network_exceptions.dart';
import '../models/user_model.dart';

@lazySingleton
class AuthMockDataSource {
  final DioClient _dioClient;

  AuthMockDataSource(this._dioClient);

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dioClient.dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException(ErrorHandler.handle(e));
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        '/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException(ErrorHandler.handle(e));
    }
  }

  Future<void> logout() async {
    try {
      await _dioClient.dio.post('/auth/logout');
    } on DioException catch (e) {
      throw NetworkException(ErrorHandler.handle(e));
    }
  }
}
