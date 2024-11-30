import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesChart extends StatefulWidget {
  const SalesChart({super.key});

  @override
  State<SalesChart> createState() => _SalesChartState();
}

class _SalesChartState extends State<SalesChart> {
  static const double barWidth = 22;
  static const shadowOpacity = 0.2;

  int touchedIndex = -1;

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

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
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
