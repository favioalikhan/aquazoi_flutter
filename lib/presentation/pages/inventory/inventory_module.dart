import 'package:flutter/material.dart';

class InventoryModule extends StatefulWidget {
  const InventoryModule({super.key});

  @override
  _InventoryModuleState createState() => _InventoryModuleState();
}

class InventoryItem {
  final int id;
  final String name;
  int stock;
  final int minStock;
  final int maxStock;

  InventoryItem({
    required this.id,
    required this.name,
    required this.stock,
    required this.minStock,
    required this.maxStock,
  });
}

class PurchaseOrder {
  final int id;
  final String product;
  final int quantity;
  final String status;

  PurchaseOrder({
    required this.id,
    required this.product,
    required this.quantity,
    required this.status,
  });
}

class _InventoryModuleState extends State<InventoryModule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();

  List<InventoryItem> inventory = [
    InventoryItem(
        id: 1, name: 'Agua 500ml', stock: 1000, minStock: 500, maxStock: 2000),
    InventoryItem(
        id: 2,
        name: 'Jugo Naranja 1L',
        stock: 300,
        minStock: 200,
        maxStock: 1000),
    InventoryItem(
        id: 3,
        name: 'Agua con gas 750ml',
        stock: 150,
        minStock: 100,
        maxStock: 500),
  ];

  List<PurchaseOrder> purchaseOrders = [
    PurchaseOrder(
        id: 1, product: 'Agua 500ml', quantity: 1000, status: 'Pendiente'),
    PurchaseOrder(
        id: 2, product: 'Jugo Naranja 1L', quantity: 500, status: 'En proceso'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _productNameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _handleAddProduct() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final productName = _productNameController.text;
        final quantity = int.parse(_quantityController.text);
        final existingProductIndex =
            inventory.indexWhere((item) => item.name == productName);

        if (existingProductIndex != -1) {
          inventory[existingProductIndex].stock += quantity;
        } else {
          inventory.add(InventoryItem(
            id: inventory.length + 1,
            name: productName,
            stock: quantity,
            minStock: (quantity * 0.2).floor(),
            maxStock: quantity * 2,
          ));
        }

        _productNameController.clear();
        _quantityController.clear();
      });
    }
  }

  void _handleCreatePurchaseOrder(String productName) {
    final product = inventory.firstWhere((item) => item.name == productName);
    final quantity = product.maxStock - product.stock;
    setState(() {
      purchaseOrders.add(PurchaseOrder(
        id: purchaseOrders.length + 1,
        product: productName,
        quantity: quantity,
        status: 'Pendiente',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulo de Inventario'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Existencias'),
            Tab(text: 'Compras'),
            Tab(text: 'Alertas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInventoryTab(),
          _buildPurchaseTab(),
          _buildAlertsTab(),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Control de Existencias',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _productNameController,
                    decoration:
                        const InputDecoration(labelText: 'Nombre del Producto'),
                    validator: (value) => value!.isEmpty
                        ? 'Por favor ingrese el nombre del producto'
                        : null,
                  ),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: 'Cantidad'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Por favor ingrese la cantidad' : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handleAddProduct,
                    child: const Text('Agregar / Actualizar Producto'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Producto')),
                  DataColumn(label: Text('Stock Actual')),
                  DataColumn(label: Text('Stock Mínimo')),
                  DataColumn(label: Text('Stock Máximo')),
                  DataColumn(label: Text('Nivel de Inventario')),
                ],
                rows: inventory
                    .map((item) => DataRow(cells: [
                          DataCell(Text(item.name)),
                          DataCell(Text(item.stock.toString())),
                          DataCell(Text(item.minStock.toString())),
                          DataCell(Text(item.maxStock.toString())),
                          DataCell(LinearProgressIndicator(
                            value: item.stock / item.maxStock,
                            minHeight: 10,
                          )),
                        ]))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gestión de Compras',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Producto')),
                  DataColumn(label: Text('Stock Actual')),
                  DataColumn(label: Text('Stock Mínimo')),
                  DataColumn(label: Text('Acción')),
                ],
                rows: inventory
                    .map((item) => DataRow(cells: [
                          DataCell(Text(item.name)),
                          DataCell(Text(item.stock.toString())),
                          DataCell(Text(item.minStock.toString())),
                          DataCell(item.stock < item.minStock
                              ? ElevatedButton(
                                  onPressed: () =>
                                      _handleCreatePurchaseOrder(item.name),
                                  child: const Text('Generar Orden'),
                                )
                              : const Text('-')),
                        ]))
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),
            Text('Órdenes de Compra',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Producto')),
                  DataColumn(label: Text('Cantidad')),
                  DataColumn(label: Text('Estado')),
                ],
                rows: purchaseOrders
                    .map((order) => DataRow(cells: [
                          DataCell(Text(order.id.toString())),
                          DataCell(Text(order.product)),
                          DataCell(Text(order.quantity.toString())),
                          DataCell(Text(order.status)),
                        ]))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsTab() {
    final lowStockItems =
        inventory.where((item) => item.stock < item.minStock).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alertas de Inventario',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            if (lowStockItems.isNotEmpty)
              ...lowStockItems.map((item) => Card(
                    color: Colors.red[100],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nivel de inventario crítico',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                              'El producto ${item.name} está por debajo del stock mínimo.'),
                          Text(
                              'Stock actual: ${item.stock}, Stock mínimo: ${item.minStock}'),
                        ],
                      ),
                    ),
                  ))
            else
              Card(
                color: Colors.green[100],
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Inventario en niveles normales',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          'Todos los productos están por encima del nivel mínimo de stock.'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
