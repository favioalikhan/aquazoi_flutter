import '../../../models/data_model/user_model.dart';

abstract class UserRepository {
  Future<UserModel> login(String email, String password);
}
