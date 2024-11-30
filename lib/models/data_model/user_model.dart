import '../entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.nombre,
    required super.apellidoPaterno,
    required super.apellidoMaterno,
    required super.puesto,
    required super.email,
    required super.accessToken,
    required super.refreshToken,
    required super.accesoSistema,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      puesto: json['puesto'],
      email: json['email'],
      accessToken: json['access'],
      refreshToken: json['refresh'],
      accesoSistema: json['acceso_sistema'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'puesto': puesto,
      'email': email,
      'access': accessToken,
      'refresh': refreshToken,
      'acceso_sistema': accesoSistema,
    };
  }
}
