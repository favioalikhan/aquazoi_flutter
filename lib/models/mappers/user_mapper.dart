import '../data_model/user_model.dart';
import '../entity/user.dart';

class UserMapper {
  static User toEntity(UserModel model) {
    return User(
      id: model.id,
      nombre: model.nombre,
      apellidoPaterno: model.apellidoPaterno,
      apellidoMaterno: model.apellidoMaterno,
      puesto: model.puesto,
      email: model.email,
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      accesoSistema: model.accesoSistema,
    );
  }

  static UserModel fromEntity(User user) {
    return UserModel(
      id: user.id,
      nombre: user.nombre,
      apellidoPaterno: user.apellidoPaterno,
      apellidoMaterno: user.apellidoMaterno,
      puesto: user.puesto,
      email: user.email,
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
      accesoSistema: user.accesoSistema,
    );
  }
}
