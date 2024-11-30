import 'package:flutter/material.dart';

class ConfigurationModule extends StatefulWidget {
  const ConfigurationModule({super.key});

  @override
  _ConfigurationModuleState createState() => _ConfigurationModuleState();
}

class _ConfigurationModuleState extends State<ConfigurationModule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulo de Configuración'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Empleados'),
            Tab(text: 'Productos'),
            Tab(text: 'Rutas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UsersTab(),
          ProductsTab(),
          RoutesTab(),
        ],
      ),
    );
  }
}

class UsersTab extends StatelessWidget {
  final List<Map<String, String>> users = [
    {'name': 'Juan Pérez', 'email': 'juan@zoiaqua.com', 'role': 'Admin'},
    {'name': 'María García', 'email': 'maria@zoiaqua.com', 'role': 'Vendedor'},
  ];

  UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gestión de Empleados',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Implementar lógica para agregar usuario
              },
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Agregar empleado'),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Rol')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: users
                    .map((user) => DataRow(
                          cells: [
                            DataCell(Text(user['name']!)),
                            DataCell(Text(user['email']!)),
                            DataCell(Text(user['role']!)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Implementar lógica para editar usuario
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Implementar lógica para eliminar usuario
                                  },
                                ),
                              ],
                            )),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsTab extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Agua 20L', 'price': 25.00, 'stock': 100},
    {'name': 'Jugo de Naranja 1L', 'price': 15.00, 'stock': 50},
  ];

  ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuración de Productos y Precios',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Implementar lógica para agregar producto
              },
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Agregar Producto'),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Precio')),
                  DataColumn(label: Text('Stock')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: products
                    .map((product) => DataRow(
                          cells: [
                            DataCell(Text(product['name'])),
                            DataCell(Text(
                                '\$${product['price'].toStringAsFixed(2)}')),
                            DataCell(Text(product['stock'].toString())),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Implementar lógica para editar producto
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Implementar lógica para eliminar producto
                                  },
                                ),
                              ],
                            )),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoutesTab extends StatelessWidget {
  final List<Map<String, String>> routes = [
    {'name': 'Ruta Norte', 'assignedTo': 'Carlos Rodríguez'},
    {'name': 'Ruta Sur', 'assignedTo': 'Ana Martínez'},
  ];

  RoutesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuración de Rutas y Distribución',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Implementar lógica para agregar ruta
              },
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Agregar Ruta'),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre de la Ruta')),
                  DataColumn(label: Text('Asignado a')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: routes
                    .map((route) => DataRow(
                          cells: [
                            DataCell(Text(route['name']!)),
                            DataCell(Text(route['assignedTo']!)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Implementar lógica para editar ruta
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Implementar lógica para eliminar ruta
                                  },
                                ),
                              ],
                            )),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
