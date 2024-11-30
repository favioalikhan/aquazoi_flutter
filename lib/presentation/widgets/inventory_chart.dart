import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class InventoryChart extends StatelessWidget {
  final List<FlSpot> inventoryData = [
    const FlSpot(0, 5000),
    const FlSpot(1, 3000),
    const FlSpot(2, 2500),
    const FlSpot(3, 2000),
  ];

  //const InventoryChart({super.key});

  //const InventoryChart({super.key});

  //const InventoryChart({super.key});

  //const InventoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inventario Actual',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: inventoryData,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value.toString(),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Agua');
                            case 1:
                              return const Text('J. Naranja');
                            case 2:
                              return const Text('J. Manzana');
                            case 3:
                              return const Text('J. Uva');
                            default:
                              return const Text('');
                          }
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
