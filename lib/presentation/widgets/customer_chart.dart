import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomerTrendChart extends StatelessWidget {
  const CustomerTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                      color: Color(0xff68737d),
                      //fontWeight: FontWeight.bold,
                      fontSize: 10);
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Lun', style: style);
                    case 2:
                      return const Text('Mar', style: style);
                    case 4:
                      return const Text('Mié', style: style);
                    case 6:
                      return const Text('Jue', style: style);
                    case 8:
                      return const Text('Vie', style: style);
                    case 10:
                      return const Text('Sáb', style: style);
                    case 12:
                      return const Text('Dom', style: style);
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 3),
                const FlSpot(2, 2),
                const FlSpot(4, 5),
                const FlSpot(6, 3.1),
                const FlSpot(8, 4),
                const FlSpot(10, 3),
                const FlSpot(11, 4),
                const FlSpot(12, 7),
              ],
              isCurved: true,
              color: Colors.blue[300]!,
              barWidth: 5,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                  show: true, color: Colors.blue[200]!.withOpacity(0.3)),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) =>
                  Colors.blueGrey, // Color de fondo del tooltip
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  return LineTooltipItem(
                    '${barSpot.y}', // El valor que se mostrará
                    const TextStyle(
                      color: Colors.white, // Color del texto
                      //fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
