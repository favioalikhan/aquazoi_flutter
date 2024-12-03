class ApiEndpoints {
  static const String login = '/token/';
  static const String refresh = '/token/refresh/';
  static const String empleados = '/empleados/'; // Lista de empleados
  static const String registroEmpleado =
      '/empleados/registro/'; // Registro de empleados
  static String updateEmpleado(int empleadoId) =>
      '/empleados/$empleadoId/'; // Actualizacion de empleado
  static String deleteEmpleado(int empleadoId) =>
      '/empleados/$empleadoId/'; // Eliminacion de empleado
  static const String departamentos =
      '/departamentos/'; // Lista de departamentos
  static String rolesPorDepartamento(int departamentoId) =>
      '/departamentos/$departamentoId/roles/';
}
