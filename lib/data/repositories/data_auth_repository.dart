// lib/data/repositories/data_auth_repository.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class DataAuthRepository implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage storage;

  DataAuthRepository({
    required this.remoteDataSource,
    required this.storage,
  });

  @override
  Future<void> authenticate(
      {required String email, required String password}) async {
    try {
      final user = await remoteDataSource.authenticate(email, password);
      // Almacenar el token o información necesaria
      await storage.write(key: 'userId', value: user.id.toString());
      await storage.write(key: 'accessToken', value: user.accessToken);
      await storage.write(key: 'refreshToken', value: user.refreshToken);
      await storage.write(key: 'userEmail', value: user.email);
      await storage.write(key: 'userNombre', value: user.nombre);
      await storage.write(
          key: 'userApellidoPaterno', value: user.apellidoPaterno);
      await storage.write(
          key: 'userApellidoMaterno', value: user.apellidoMaterno);
      await storage.write(key: 'userPuesto', value: user.puesto);
      await storage.write(
          key: 'accesoSistema', value: user.accesoSistema.toString());
    } catch (e) {
      print('Error en repository: $e');
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userIdStr = await storage.read(key: 'userId');
      print('userIdStr: $userIdStr');
      final userEmail = await storage.read(key: 'userEmail');
      print('userEmail: $userEmail');
      final userNombre = await storage.read(key: 'userNombre');
      print('userNombre: $userNombre');
      final userApellidoPaterno =
          await storage.read(key: 'userApellidoPaterno');
      print('userApellidoPaterno: $userApellidoPaterno');
      final userApellidoMaterno =
          await storage.read(key: 'userApellidoMaterno');
      print('userApellidoMaterno: $userApellidoMaterno');
      final userPuesto = await storage.read(key: 'userPuesto');
      print('userPuesto: $userPuesto');
      final accessToken = await storage.read(key: 'accessToken');
      final refreshToken = await storage.read(key: 'refreshToken');
      final accesoSistemaStr = await storage.read(key: 'accesoSistema');
      print('accesoSistemaStr: $accesoSistemaStr');

      if (userIdStr != null &&
          userEmail != null &&
          accessToken != null &&
          refreshToken != null) {
        final userId = int.tryParse(userIdStr) ?? 0;
        final accesoSistema = accesoSistemaStr == 'true';

        return User(
          id: userId,
          nombre: userNombre ?? '',
          apellidoPaterno: userApellidoPaterno ?? '',
          apellidoMaterno: userApellidoMaterno ?? '',
          puesto: userPuesto ?? '',
          email: userEmail,
          accessToken: accessToken,
          refreshToken: refreshToken,
          accesoSistema: accesoSistema,
        );
      } else {
        throw Exception('No hay un usuario autenticado');
      }
    } catch (e) {
      print('Error en getCurrentUser: $e');
      throw Exception('Error al obtener el usuario actual: $e');
    }
  }

  @override
  Future<void> logout() async {
    await storage.deleteAll();
  }
}
