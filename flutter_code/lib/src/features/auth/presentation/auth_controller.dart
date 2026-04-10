import 'package:notes_app/src/features/auth/data/auth_repository.dart';
import 'package:notes_app/src/features/auth/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  final _storage = const FlutterSecureStorage();

  @override
  FutureOr<User?> build() async {
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(authRepositoryProvider)
          .login(email, password);
      await _storage.write(key: 'auth_token', value: response.token);
      return response.user;
    });
  }
}

