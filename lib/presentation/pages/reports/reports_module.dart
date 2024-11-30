import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ReportsModule extends StatefulWidget {
  const ReportsModule({super.key});

  @override
  _ReportsModuleState createState() => _ReportsModuleState();
}

class _ReportsModuleState extends State<ReportsModule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String _selectedFilter = 'Todos';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildDateRangePicker() {
    return Row(
      children: [
        Text('Desde: ${DateFormat('dd/MM/yyyy').format(_startDate)}'),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _startDate,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != _startDate) {
              setState(() {
                _startDate = picked;
              });
            }
          },
        ),
        Text('Hasta: ${DateFormat('dd/MM/yyyy').format(_endDate)}'),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _endDate,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != _endDate) {
              setState(() {
                _endDate = picked;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButton<String>(
      value: _selectedFilter,
      onChanged: (String? newValue) {
        setState(() {
          _selectedFilter = newValue!;
        });
      },
      items: <String>['Todos', 'Agua', 'Jugos']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildSalesReport() {
    return Column(
      children: [
        _buildDateRangePicker(),
        _buildFilterDropdown(),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.7,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              maxY: 20,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  margin: 16,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Ene';
                      case 1:
                        return 'Feb';
                      case 2:
                        return 'Mar';
                      case 3:
                        return 'Abr';
                      case 4:
                        return 'May';
                      case 5:
                        return 'Jun';
                      default:
                        return '';
                    }
                  },
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(y: 8, colors: [Colors.blue])
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(y: 10, colors: [Colors.blue])
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(y: 14, colors: [Colors.blue])
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(y: 15, colors: [Colors.blue])
                ]),
                BarChartGroupData(x: 4, barRods: [
                  BarChartRodData(y: 13, colors: [Colors.blue])
                ]),
                BarChartGroupData(x: 5, barRods: [
                  BarChartRodData(y: 18, colors: [Colors.blue])
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryReport() {
    return Column(
      children: [
        _buildFilterDropdown(),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(
                  color: Colors.blue[400],
                  value: 40,
                  title: 'Agua 20L',
                  radius: 50,
                  titleStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                PieChartSectionData(
                  color: Colors.green[300],
                  value: 30,
                  title: 'Jugo Naranja',
                  radius: 50,
                  titleStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                PieChartSectionData(
                  color: Colors.red[300],
                  value: 15,
                  title: 'Jugo Manzana',
                  radius: 50,
                  titleStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                PieChartSectionData(
                  color: Colors.yellow[300],
                  value: 15,
                  title: 'Otros',
                  radius: 50,
                  titleStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductionReport() {
    return Column(
      children: [
        _buildDateRangePicker(),
        _buildFilterDropdown(),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'LUN';
                      case 1:
                        return 'MAR';
                      case 2:
                        return 'MIE';
                      case 3:
                        return 'JUE';
                      case 4:
                        return 'VIE';
                      default:
                        return '';
                    }
                  },
                ),
              ),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: 4,
              minY: 0,
              maxY: 6,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 3),
                    const FlSpot(1, 2),
                    const FlSpot(2, 5),
                    const FlSpot(3, 3.1),
                    const FlSpot(4, 4),
                  ],
                  isCurved: true,
                  colors: [Colors.blue],
                  barWidth: 5,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                      show: true, colors: [Colors.blue.withOpacity(0.3)]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDistributionReport() {
    return Column(
      children: [
        _buildDateRangePicker(),
        _buildFilterDropdown(),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.7,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              maxY: 100,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  margin: 16,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Ruta A';
                      case 1:
                        return 'Ruta B';
                      case 2:
                        return 'Ruta C';
                      case 3:
                        return 'Ruta D';
                      default:
                        return '';
                    }
                  },
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(y: 85, colors: [Colors.green])
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(y: 92, colors: [Colors.green])
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(y: 78, colors: [Colors.green])
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(y: 88, colors: [Colors.green])
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulo de Reportes'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Ventas'),
            Tab(text: 'Inventario'),
            Tab(text: 'Producción'),
            Tab(text: 'Distribución'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSalesReport(),
          )),
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildInventoryReport(),
          )),
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildProductionReport(),
          )),
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDistributionReport(),
          )),
        ],
      ),
    );
  }
}
