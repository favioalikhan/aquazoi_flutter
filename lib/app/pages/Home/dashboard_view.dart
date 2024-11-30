import 'package:flutter/material.dart';

import '../../../presentation/widgets/customer_chart.dart';
import '../../../presentation/widgets/price_chart.dart';
import '../../../presentation/widgets/product_chart.dart';
import '../../../presentation/widgets/sales_chart.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Zoi Aqua'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resumen de Ventas',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              const SalesChart(),
              const SizedBox(height: 24),
              Text(
                'Distribución de Productos',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const ProductDistributionChart(),
              const SizedBox(height: 30),
              Text(
                'Tendencia de Clientes',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              const CustomerTrendChart(),
              const SizedBox(height: 24),
              Text(
                'Relación Precio-Volumen',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              const PriceVolumeChart(),
            ],
          ),
        ),
      ),
    );
  }
}
