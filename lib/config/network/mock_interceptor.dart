import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';

class MockInterceptor extends Interceptor {
  static const String _boxName = 'mock_users_box';

  Future<List<Map<String, String>>> _getMockUsers() async {
    final box = await Hive.openBox(_boxName);
    if (box.isEmpty) {
      final defaultUsers = [
        {
          'id': '1',
          'name': 'Ahmed Mohamed',
          'email': 'ahmed@cure.com',
          'password': '123456',
          'token': 'mock_token_ahmed_2025',
        },
        {
          'id': '2',
          'name': 'Sara Ali',
          'email': 'sara@cure.com',
          'password': '123456',
          'token': 'mock_token_sara_2025',
        },
      ];
      for (final user in defaultUsers) {
        await box.put(user['email'], user);
      }
    }

    final list = <Map<String, String>>[];
    for (final key in box.keys) {
      final dynamic val = box.get(key);
      if (val is Map) {
        list.add(Map<String, String>.from(val));
      }
    }
    return list;
  }

  Future<void> _addMockUser(Map<String, String> user) async {
    final box = await Hive.openBox(_boxName);
    await box.put(user['email'], user);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final path = options.path;
    final method = options.method.toUpperCase();

    if (path.endsWith('/auth/login') && method == 'POST') {
      await Future.delayed(const Duration(seconds: 2));
      final data = options.data as Map<String, dynamic>?;
      final email = data?['email'] as String?;
      final password = data?['password'] as String?;

      final mockUsers = await _getMockUsers();
      for (final user in mockUsers) {
        if (user['email'] == email && user['password'] == password) {
          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: 200,
              data: {
                'id': user['id'],
                'name': user['name'],
                'email': user['email'],
                'token': user['token'],
              },
            ),
          );
          return;
        }
      }
      handler.reject(
        DioException(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: 400,
            data: {'message': 'Invalid email or password'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );
      return;
    }

    if (path.endsWith('/auth/register') && method == 'POST') {
      await Future.delayed(const Duration(seconds: 2));
      final data = options.data as Map<String, dynamic>?;
      final name = data?['name'] as String? ?? '';
      final email = data?['email'] as String? ?? '';
      final password = data?['password'] as String? ?? '';

      final mockUsers = await _getMockUsers();
      final emailExists = mockUsers.any((user) => user['email'] == email);
      if (emailExists) {
        handler.reject(
          DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: 400,
              data: {'message': 'Email already registered'},
            ),
            type: DioExceptionType.badResponse,
          ),
        );
        return;
      }

      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final token =
          'mock_token_${name.toLowerCase().replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}';

      final newUser = {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'token': token,
      };
      await _addMockUser(newUser);

      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {'id': id, 'name': name, 'email': email, 'token': token},
        ),
      );
      return;
    }

    if (path.endsWith('/auth/logout') && method == 'POST') {
      await Future.delayed(const Duration(milliseconds: 500));
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {'message': 'Logout successful'},
        ),
      );
      return;
    }

    if (path.endsWith('/booking') && method == 'POST') {
      await Future.delayed(const Duration(seconds: 2));
      final data = options.data as Map<String, dynamic>?;
      final service = data?['service'] as String?;
      final time = data?['time'] as String?;

      if (service == null || time == null) {
        handler.reject(
          DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: 400,
              data: {'message': 'Invalid booking data'},
            ),
            type: DioExceptionType.badResponse,
          ),
        );
        return;
      }

      final bookingId = DateTime.now().millisecondsSinceEpoch.toString();
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            'id': bookingId,
            'service': service,
            'date': data?['date'] as String? ?? data?['dayName'] as String? ?? '',
            'time': time,
            'notes': data?['notes'] as String? ?? '',
            'status': 'pending',
            'message': 'Booking confirmed successfully',
          },
        ),
      );
      return;
    }

    handler.next(options);
  }
}
