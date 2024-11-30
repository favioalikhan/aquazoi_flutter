// lib/domain/usecases/get_current_user_usecase.dart
import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase extends UseCase<User?, void> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Stream<User?>> buildUseCaseStream(void params) async {
    final controller = StreamController<User?>();
    try {
      final user = await repository.getCurrentUser();
      controller.add(user);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}
