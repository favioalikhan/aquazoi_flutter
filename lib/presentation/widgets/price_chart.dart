import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PriceVolumeChart extends StatelessWidget {
  const PriceVolumeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: ScatterChart(
        ScatterChartData(
          scatterSpots: [
            ScatterSpot(
              4,
              45,
              dotPainter: FlDotCirclePainter(
                color: Colors.blue,
                radius: 8,
              ),
            ),
            ScatterSpot(
              2,
              37,
              dotPainter: FlDotCirclePainter(
                color: Colors.blue,
                radius: 8,
              ),
            ),
            ScatterSpot(
              8,
              72,
              dotPainter: FlDotCirclePainter(
                color: Colors.blue,
                radius: 8,
              ),
            ),
            ScatterSpot(
              6,
              56,
              dotPainter: FlDotCirclePainter(
                color: Colors.blue,
                radius: 8,
              ),
            ),
            ScatterSpot(
              3,
              40,
              dotPainter: FlDotCirclePainter(
                color: Colors.blue,
                radius: 8,
              ),
            ),
            ScatterSpot(
              5,
              50,
              dotPainter: FlDotCirclePainter(
                color: Colors.blue,
                radius: 8,
              ),
            ),
            ScatterSpot(
              7,
              65,
              dotPainter: FlDotCirclePainter(
                color: Colors.blue,
                radius: 8,
              ),
            ),
            ScatterSpot(
              9,
              80,
              dotPainter: FlDotCirclePainter(
                color: Colors.blue,
                radius: 8,
              ),
            ),
          ],
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 100,
          scatterTouchData: ScatterTouchData(
            enabled: true,
            handleBuiltInTouches: true,
            touchTooltipData: ScatterTouchTooltipData(
              tooltipBorder: BorderSide.none,
              tooltipPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              getTooltipItems: (ScatterSpot touchedSpot) {
                return ScatterTooltipItem(
                  //'X: ${touchedSpot.x.toStringAsFixed(1)}\nY: ${touchedSpot.y.toStringAsFixed(1)}',
                  touchedSpot.y.toStringAsFixed(1),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    //fontWeight: FontWeight.bold,
                  ),
                );
              },
              getTooltipColor: (ScatterSpot touchedSpot) {
                return Colors.blueGrey;
              },
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 12);
                  switch (value.toInt()) {
                    case 2:
                      return const Text('2L', style: style);
                    case 4:
                      return const Text('4L', style: style);
                    case 6:
                      return const Text('6L', style: style);
                    case 8:
                      return const Text('8L', style: style);
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(
                        color: Color(0xff68737d),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
