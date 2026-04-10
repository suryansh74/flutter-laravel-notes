import 'package:dio/dio.dart';
import 'package:notes_app/src/features/auth/domain/user.dart';
import 'package:notes_app/src/shared/network/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._dio);
  final Dio _dio;

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      // Add these two print statements!
      print('=== DIO ERROR ===');
      print(e.message);
      print(e.response?.data);
      print('=================');

      throw e.response?.data['message'] ?? 'Login failed: ${e.message}';
    }
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(dioProvider));
}
