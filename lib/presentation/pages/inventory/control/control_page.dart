import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/data_model/produccion_model.dart';
import '../../../../models/data_model/soplado_model.dart';
import '../../../../models/data_model/empleado_model.dart';

class ControlTabPage extends StatefulWidget {
  const ControlTabPage({super.key});

  @override
  State<ControlTabPage> createState() => _ControlTabPageState();
}

class _ControlTabPageState extends State<ControlTabPage> {
  String selectedFilter = 'Diciembre 2023';
  final List<String> filterOptions = [
    'Octubre 2023',
    'Noviembre 2023',
    'Diciembre 2023',
    'Enero 2024'
  ];

  final List<ProduccionModel> produccionData = [
    ProduccionModel(
      id: 1,
      fechaProduccion: DateTime(2023, 12, 10),
      numeroLote: 'L-1001',
      fechaVencimiento: DateTime(2024, 6, 10),
      botellasEnvasadas: 1000,
      botellasMalogradas: 50,
      tapasMalogradas: 20,
      etiquetasMalogradas: 10,
      totalBotellasBuenas: 930,
      totalPaquetes: 93,
    ),
    // Agrega más datos si es necesario
  ];

  final List<SopladoModel> sopladoData = [
    SopladoModel(
      id: 1,
      fecha: DateTime(2023, 12, 5),
      proveedorPreforma: 'Proveedor A',
      pesoGramos: 20,
      volumenBotellaMl: 500,
      produccionBuena: 900,
      produccionDanada: 100,
      produccionTotal: 1000,
    ),
    // Agrega más datos si es necesario
  ];

  void _onAddProduccion() {
    // Lógica para agregar nueva producción
    print("Agregar Producción");
  }

  void _onAddSoplado() {
    // Lógica para agregar nuevo soplado
    print("Agregar Soplado");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control de Producción y Soplado')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                context,
                title: 'Control de Producción',
                data: produccionData,
                filterOptions: filterOptions,
                selectedFilter: selectedFilter,
                onFilterChange: (value) {
                  setState(() {
                    selectedFilter = value!;
                    // Actualiza lógica de filtro aquí
                  });
                },
                onAdd: _onAddProduccion,
                columns: const [
                  DataColumn(label: Text('Fecha')),
                  DataColumn(label: Text('Lote')),
                  DataColumn(label: Text('Botellas Buenas')),
                  DataColumn(label: Text('Malogradas')),
                ],
                rows: produccionData.map((p) {
                  return DataRow(cells: [
                    DataCell(Text(
                        DateFormat('dd-MM-yyyy').format(p.fechaProduccion))),
                    DataCell(Text(p.numeroLote)),
                    DataCell(Text(p.totalBotellasBuenas.toString())),
                    DataCell(Text(p.botellasMalogradas.toString())),
                    DataCell(Text(p.empleado.toString())),
                  ]);
                }).toList(),
              ),
              const SizedBox(height: 32),
              _buildSection(
                context,
                title: 'Control de Soplado',
                data: sopladoData,
                filterOptions: filterOptions,
                selectedFilter: selectedFilter,
                onFilterChange: (value) {
                  setState(() {
                    selectedFilter = value!;
                    // Actualiza lógica de filtro aquí
                  });
                },
                onAdd: _onAddSoplado,
                columns: const [
                  DataColumn(label: Text('Fecha')),
                  DataColumn(label: Text('Proveedor')),
                  DataColumn(label: Text('Producción Buena')),
                  DataColumn(label: Text('Producción Dañada')),
                  DataColumn(label: Text('Producción Total')),
                ],
                rows: sopladoData.map((s) {
                  return DataRow(cells: [
                    DataCell(Text(DateFormat('dd-MM-yyyy').format(s.fecha))),
                    DataCell(Text(s.proveedorPreforma)),
                    DataCell(Text(s.produccionBuena.toString())),
                    DataCell(Text(s.produccionDanada.toString())),
                    DataCell(Text(s.produccionTotal.toString())),
                  ]);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection<T>(
    BuildContext context, {
    required String title,
    required List<T> data,
    required List<String> filterOptions,
    required String selectedFilter,
    required Function(String?) onFilterChange,
    required Function onAdd,
    required List<DataColumn> columns,
    required List<DataRow> rows,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              value: selectedFilter,
              items: filterOptions.map((option) {
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
              onChanged: onFilterChange,
            ),
            ElevatedButton(
              onPressed: () => onAdd(),
              child: const Text('Agregar'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: columns, rows: rows),
          ),
        ),
      ],
    );
  }
}
