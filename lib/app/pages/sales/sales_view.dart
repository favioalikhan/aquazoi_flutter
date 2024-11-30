import 'package:flutter/material.dart';

import '../../../presentation/widgets/sales_chart.dart';
import '../../widgets/orders/order_form.dart';
import '../../widgets/orders/orders_table.dart';
import './sales_controller.dart';

class SalesModule extends StatefulWidget {
  const SalesModule({super.key});

  @override
  _SalesDashboardState createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesModule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SalesController controller = SalesController();

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
            OrderForm(onSubmit: controller.addOrder),
            const SizedBox(height: 32),
            Text('Seguimiento de Pedidos',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            OrdersTable(orders: controller.orders),
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
          const SalesChart(),
        ],
      ),
    );
  }
}
