// lib/app/services/session_manager.dart

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/datasources/database.dart';
import '../../data/mappers/employee_mapper.dart';

class SecureSessionManager {
  final AppDatabase _database;
  final FlutterSecureStorage _secureStorage;
  Employee? _currentEmployee;
  int? _currentSessionId;

  // Constantes para las claves de almacenamiento seguro
  static const String _sessionTokenKey = 'session_token';
  static const String _employeeIdKey = 'employee_id';
  static const String _sessionIdKey = 'session_id';

  SecureSessionManager(this._database)
      : _secureStorage = const FlutterSecureStorage();

  // Getter para el empleado actual con carga diferida
  Future<Employee?> get currentEmployee async {
    if (_currentEmployee == null) {
      await _loadStoredSession();
    }
    return _currentEmployee;
  }

  // Verificar si hay una sesión activa
  Future<bool> get isAuthenticated async {
    if (_currentEmployee == null) {
      await _loadStoredSession();
    }
    return _currentEmployee != null;
  }

  // Generar token de sesión seguro
  String _generateSessionToken(int employeeId, DateTime timestamp) {
    final data =
        '$employeeId-${timestamp.toIso8601String()}-${Platform.operatingSystem}';
    return sha256.convert(utf8.encode(data)).toString();
  }

  // Cargar sesión almacenada
  Future<bool> _loadStoredSession() async {
    try {
      final storedSessionToken =
          await _secureStorage.read(key: _sessionTokenKey);
      final storedEmployeeId = await _secureStorage.read(key: _employeeIdKey);
      final storedSessionId = await _secureStorage.read(key: _sessionIdKey);

      if (storedSessionToken == null ||
          storedEmployeeId == null ||
          storedSessionId == null) {
        return false;
      }

      // Validar la sesión en la base de datos
      final sessionValid = await _validateStoredSession(
        int.parse(storedEmployeeId),
        int.parse(storedSessionId),
        storedSessionToken,
      );

      if (sessionValid) {
        // Cargar datos del empleado
        _currentSessionId = int.parse(storedSessionId);
        _currentEmployee = await _loadEmployeeData(int.parse(storedEmployeeId));
        return true;
      } else {
        await _clearStoredSession();
        return false;
      }
    } catch (e) {
      print('Error al cargar la sesión: $e');
      await _clearStoredSession();
      return false;
    }
  }

  // Iniciar sesión con persistencia
  Future<bool> startSession(Employee employee) async {
    try {
      final deviceInfo = await _getDeviceInfo();
      final sessionToken = _generateSessionToken(employee.id, DateTime.now());

      final sessionEntry = RegistroSesionesCompanion(
        usuarioId: Value(employee.id),
        tipoUsuario: const Value('empleado'),
        ipDireccion: Value(deviceInfo.ipAddress),
        dispositivo: Value(deviceInfo.deviceName),
        exitoso: const Value(true),
      );

      final sessionId =
          await _database.into(_database.registroSesiones).insert(sessionEntry);

      // Almacenar datos de sesión de forma segura
      await Future.wait([
        _secureStorage.write(key: _sessionTokenKey, value: sessionToken),
        _secureStorage.write(
            key: _employeeIdKey, value: employee.id.toString()),
        _secureStorage.write(key: _sessionIdKey, value: sessionId.toString()),
      ]);

      _currentSessionId = sessionId;
      _currentEmployee = employee;

      return true;
    } catch (e) {
      print('Error al iniciar sesión: $e');
      await _clearStoredSession();
      return false;
    }
  }

  // Cerrar sesión y limpiar datos
  Future<bool> endSession() async {
    try {
      if (_currentSessionId != null) {
        await (_database.update(_database.registroSesiones)
              ..where((tbl) => tbl.sesionId.equals(_currentSessionId!)))
            .write(RegistroSesionesCompanion(
          fechaFin: Value(DateTime.now()),
        ));
      }

      await _clearStoredSession();
      return true;
    } catch (e) {
      print('Error al cerrar sesión: $e');
      return false;
    }
  }

  // Limpiar datos almacenados
  Future<void> _clearStoredSession() async {
    _currentSessionId = null;
    _currentEmployee = null;
    await Future.wait([
      _secureStorage.delete(key: _sessionTokenKey),
      _secureStorage.delete(key: _employeeIdKey),
      _secureStorage.delete(key: _sessionIdKey),
    ]);
  }

  // Validar sesión almacenada
  Future<bool> _validateStoredSession(
      int employeeId, int sessionId, String sessionToken) async {
    try {
      final session = await (_database.select(_database.registroSesiones)
            ..where((tbl) =>
                tbl.sesionId.equals(sessionId) &
                tbl.usuarioId.equals(employeeId) &
                tbl.fechaFin.isNull()))
          .getSingleOrNull();

      return session != null;
    } catch (e) {
      print('Error al validar sesión: $e');
      return false;
    }
  }

  // Cargar datos del empleado
  Future<Employee?> _loadEmployeeData(int employeeId) async {
    try {
      final empleadoData = await (_database.select(_database.empleados)
            ..where((tbl) => tbl.empleadoId.equals(employeeId)))
          .getSingleOrNull();

      if (empleadoData != null) {
        return EmployeeMapper.fromMap(empleadoData.toJson());
      }
      return null;
    } catch (e) {
      print('Error al cargar datos del empleado: $e');
      return null;
    }
  }

  // Obtener información del dispositivo
  Future<DeviceInfo> _getDeviceInfo() async {
    String ipAddress = 'unknown';
    String deviceName = Platform.operatingSystem;

    try {
      final interfaces = await NetworkInterface.list();
      for (var interface in interfaces) {
        if (interface.addresses.isNotEmpty) {
          ipAddress = interface.addresses.first.address;
          break;
        }
      }
    } catch (e) {
      print('Error al obtener IP: $e');
    }

    return DeviceInfo(ipAddress, deviceName);
  }
}

// Clase auxiliar para información del dispositivo
class DeviceInfo {
  final String ipAddress;
  final String deviceName;

  DeviceInfo(this.ipAddress, this.deviceName);
}
