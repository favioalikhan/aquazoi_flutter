import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/order.dart';

class OrdersTable extends StatelessWidget {
  final List<Order> orders;

  const OrdersTable({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  DataCell(Text(
                      DateFormat('dd/MM/yyyy').format(order.deliveryDate))),
                ]))
            .toList(),
      ),
    );
  }
}
