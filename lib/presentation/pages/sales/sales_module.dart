import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesModule extends StatefulWidget {
  const SalesModule({super.key});

  @override
  _SalesDashboardState createState() => _SalesDashboardState();
}

class Order {
  final int id;
  final String clientName;
  final String phone;
  final String product;
  final int quantity;
  final String status;
  final DateTime deliveryDate;

  Order({
    required this.id,
    required this.clientName,
    required this.phone,
    required this.product,
    required this.quantity,
    required this.status,
    required this.deliveryDate,
  });
}

class _SalesDashboardState extends State<SalesModule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _quantityController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedProduct;
  static const double barWidth = 22;
  static const shadowOpacity = 0.2;

  int touchedIndex = -1;

  List<Order> orders = [
    Order(
        id: 1,
        clientName: 'Tienda ABC',
        phone: '123-456-7890',
        product: 'Agua 500ml x 24',
        quantity: 10,
        status: 'En proceso',
        deliveryDate: DateTime.now().add(const Duration(days: 2))),
    Order(
        id: 2,
        clientName: 'Restaurante XYZ',
        phone: '098-765-4321',
        product: 'Jugo Naranja 1L x 12',
        quantity: 5,
        status: 'Enviado',
        deliveryDate: DateTime.now().add(const Duration(days: 1))),
    Order(
        id: 3,
        clientName: 'Hotel 123',
        phone: '555-123-4567',
        product: 'Agua con gas 750ml x 15',
        quantity: 8,
        status: 'Entregado',
        deliveryDate: DateTime.now()),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _clientNameController.dispose();
    _phoneController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        orders.add(Order(
          id: orders.length + 1,
          clientName: _clientNameController.text,
          phone: _phoneController.text,
          product: _selectedProduct!,
          quantity: int.parse(_quantityController.text),
          status: 'En proceso',
          deliveryDate: _selectedDate!,
        ));
      });
      _formKey.currentState!.reset();
      _selectedProduct = null;
      _selectedDate = null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pedido registrado con éxito')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulo de Ventas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pedidos'),
            Tab(text: 'Facturación'),
            Tab(text: 'Análisis'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersTab(),
          _buildBillingTab(),
          _buildAnalysisTab(),
        ],
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    String text;
    if (value == 0) {
      text = '0';
    } else {
      text = '${value.toInt()}k';
    }
    return SideTitleWidget(
      angle: value < 0 ? -45 : 45,
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registro de Pedidos',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _clientNameController,
                    decoration:
                        const InputDecoration(labelText: 'Nombre del Cliente'),
                    validator: (value) => value!.isEmpty
                        ? 'Por favor ingrese el nombre del cliente'
                        : null,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Teléfono'),
                    validator: (value) =>
                        value!.isEmpty ? 'Por favor ingrese el teléfono' : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedProduct,
                    decoration: const InputDecoration(labelText: 'Producto'),
                    items: [
                      'Agua 500ml',
                      'Jugo Naranja 1L',
                      'Agua con gas 750ml'
                    ]
                        .map((product) => DropdownMenuItem(
                            value: product, child: Text(product)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedProduct = value),
                    validator: (value) => value == null
                        ? 'Por favor seleccione un producto'
                        : null,
                  ),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: 'Cantidad'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Por favor ingrese la cantidad' : null,
                  ),
                  ListTile(
                    title: Text(_selectedDate == null
                        ? 'Seleccionar Fecha de Entrega'
                        : 'Fecha de Entrega: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitOrder,
                    child: const Text('Registrar Pedido'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Seguimiento de Pedidos',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Cliente')),
                  DataColumn(label: Text('Teléfono')),
                  DataColumn(label: Text('Producto')),
                  DataColumn(label: Text('Cantidad')),
                  DataColumn(label: Text('Estado')),
                  DataColumn(label: Text('Fecha de Entrega')),
                ],
                rows: orders
                    .map((order) => DataRow(cells: [
                          DataCell(Text(order.id.toString())),
                          DataCell(Text(order.clientName)),
                          DataCell(Text(order.phone)),
                          DataCell(Text(order.product)),
                          DataCell(Text(order.quantity.toString())),
                          DataCell(Text(order.status)),
                          DataCell(Text(DateFormat('dd/MM/yyyy')
                              .format(order.deliveryDate))),
                        ]))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingTab() {
    return const Center(child: Text('Facturación - En desarrollo'));
  }

  Widget _buildAnalysisTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Análisis de Ventas',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                maxY: 20,
                minY: -20,
                groupsSpace: 12,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.blueGrey,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      double value = rod.toY;
                      return BarTooltipItem(
                        '${value.abs().toStringAsFixed(1)}k',
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  handleBuiltInTouches: true,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        );
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = 'Lun';
                            break;
                          case 1:
                            text = 'Mar';
                            break;
                          case 2:
                            text = 'Mier';
                            break;
                          case 3:
                            text = 'Jue';
                            break;
                          case 4:
                            text = 'Vie';
                            break;
                          case 5:
                            text = 'Sáb';
                            break;
                          case 6:
                            text = 'Dom';
                            break;
                          default:
                            text = '';
                            break;
                        }
                        return Text(text, style: style);
                      },
                      reservedSize: 32,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: leftTitles,
                      interval: 5,
                      reservedSize: 42,
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 5 == 0,
                  getDrawingHorizontalLine: (value) {
                    if (value == 0) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.1),
                        strokeWidth: 3,
                      );
                    }
                    return FlLine(
                      color: Colors.grey.withOpacity(0.05),
                      strokeWidth: 0.8,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  generateGroup(0, 8, -4),
                  generateGroup(1, 10, -5),
                  generateGroup(2, 14, -7),
                  generateGroup(3, 15, -7.5),
                  generateGroup(4, 13, -6.5),
                  generateGroup(5, 18, -9),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData generateGroup(int x, double positive, double negative) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          toY: positive,
          width: barWidth,
          color: Colors.blue[300],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
        BarChartRodData(
          toY: negative,
          width: barWidth,
          color: Colors.blue[300]?.withOpacity(shadowOpacity),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }
}
