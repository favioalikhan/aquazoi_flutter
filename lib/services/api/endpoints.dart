class ApiEndpoints {
  static const String login = '/token/';
  static const String refresh = '/token/refresh/';
  static const String empleados = '/empleados/'; // Lista de empleados
  static const String registroEmpleado =
      '/empleados/registro/'; // Registro de empleados
  static const String departamentos =
      '/departamentos/'; // Lista de departamentos
  static String rolesPorDepartamento(int departamentoId) =>
      '/departamentos/$departamentoId/roles/';
  static const String inventario = '/inventarios/'; //Lista del inventario
  static const String producto = '/productos/'; //Lista del inventario

  static String deleteProducto(int productoId) => '/productos/$productoId/';

  static String updateProducto(int productoId) => '/productos/$productoId/';
}
