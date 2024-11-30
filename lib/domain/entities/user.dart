class User {
  final int id;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String puesto;
  final String email;
  final String accessToken;
  final String refreshToken;
  final bool accesoSistema;

  User({
    required this.id,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.puesto,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    required this.accesoSistema,
  });
}
