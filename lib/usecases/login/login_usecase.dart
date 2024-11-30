import '../../models/data_model/user_model.dart';
import '../../repositories/data/auth/user_repository.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<UserModel> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
