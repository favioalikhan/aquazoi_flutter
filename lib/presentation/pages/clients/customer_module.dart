import 'package:flutter/material.dart';

class CustomerModule extends StatefulWidget {
  const CustomerModule({super.key});

  @override
  _CustomerModuleState createState() => _CustomerModuleState();
}

class Customer {
  final String name;
  final String phone;
  final String address;
  final String cluster;

  Customer({
    required this.name,
    required this.phone,
    required this.address,
    required this.cluster,
  });
}

final List<Customer> customers = [
  Customer(
    name: 'Juan Pérez',
    phone: '123-456-7890',
    address: 'Calle Principal 123',
    cluster: 'Norte',
  ),
  Customer(
    name: 'María González',
    phone: '987-654-3210',
    address: 'Avenida Central 456',
    cluster: 'Sur',
  ),
  Customer(
    name: 'Carlos Rodríguez',
    phone: '555-123-4567',
    address: 'Plaza Mayor 789',
    cluster: 'Este',
  ),
  Customer(
    name: 'Ana Martínez',
    phone: '444-789-0123',
    address: 'Boulevard Oeste 321',
    cluster: 'Oeste',
  ),
];

class _CustomerModuleState extends State<CustomerModule>
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
        title: const Text('Módulo de Clientes'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Gestión'),
            Tab(text: 'Zonas'),
            Tab(text: 'Chatbot'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          GestionClientesTab(),
          ClustersTab(),
          WhatsAppTab(),
        ],
      ),
    );
  }
}

class GestionClientesTab extends StatelessWidget {
  const GestionClientesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registro de Cliente',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Contacto',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Dirección',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Cluster Geográfico',
              ),
              items: ['Norte', 'Sur', 'Este', 'Oeste']
                  .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Guardar Cliente'),
              onPressed: () {},
            ),
            const SizedBox(height: 32),
            Text('Lista de Clientes',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const ClientesDataTable(),
          ],
        ),
      ),
    );
  }
}

class ClientesDataTable extends StatelessWidget {
  const ClientesDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Contacto')),
          DataColumn(label: Text('Dirección')),
          DataColumn(label: Text('Cluster')),
          DataColumn(label: Text('Acciones')),
        ],
        rows: customers
            .map((customer) => DataRow(
                  cells: [
                    DataCell(Text(customer.name)),
                    DataCell(Text(customer.phone)),
                    DataCell(Text(customer.address)),
                    DataCell(Text(customer.cluster)),
                    DataCell(ElevatedButton(
                      onPressed: () {},
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Eliminar Cliente'),
                    )),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

class ClustersTab extends StatelessWidget {
  const ClustersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Segmentación de Clientes',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.grey[200],
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, size: 48, color: Colors.blue),
                      Text('Mapa de segmentación aquí'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text('Resumen de Clusters',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            DataTable(
              columns: const [
                DataColumn(label: Text('Cluster')),
                DataColumn(label: Text('Número de Clientes')),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text('Norte')),
                  DataCell(Text(customers
                      .where((c) => c.cluster == 'Norte')
                      .length
                      .toString())),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Sur')),
                  DataCell(Text(customers
                      .where((c) => c.cluster == 'Sur')
                      .length
                      .toString())),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Este')),
                  DataCell(Text(customers
                      .where((c) => c.cluster == 'Este')
                      .length
                      .toString())),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Oeste')),
                  DataCell(Text(customers
                      .where((c) => c.cluster == 'Oeste')
                      .length
                      .toString())),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WhatsAppTab extends StatelessWidget {
  const WhatsAppTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Integración con WhatsApp Business',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Número de WhatsApp',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Cliente',
              ),
              items: ['Juan Pérez', 'María González']
                  .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Vincular WhatsApp'),
              onPressed: () {},
            ),
            const SizedBox(height: 32),
            Text('Flujos de Conversación del Chatbot',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const FlujosConversacionDataTable(),
          ],
        ),
      ),
    );
  }
}

class FlujosConversacionDataTable extends StatelessWidget {
  const FlujosConversacionDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Nombre del Flujo')),
          DataColumn(label: Text('Descripción')),
          DataColumn(label: Text('Acciones')),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(Text('Bienvenida')),
            const DataCell(Text('Mensaje inicial para nuevos clientes')),
            DataCell(ElevatedButton(
              child: const Text('Editar'),
              onPressed: () {},
            )),
          ]),
          DataRow(cells: [
            const DataCell(Text('Consulta de Pedido')),
            const DataCell(Text('Flujo para consultar estado de pedidos')),
            DataCell(ElevatedButton(
              child: const Text('Editar'),
              onPressed: () {},
            )),
          ]),
          // Más flujos de conversación aquí
        ],
      ),
    );
  }
}
