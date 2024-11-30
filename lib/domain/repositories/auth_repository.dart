// lib/domain/repositories/auth_repository.dart
import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> authenticate({required String email, required String password});
  Future<User?> getCurrentUser();
  Future<void> logout();
}
