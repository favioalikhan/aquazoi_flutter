import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/order.dart';

class OrderForm extends StatefulWidget {
  final Function(Order) onSubmit;

  const OrderForm({super.key, required this.onSubmit});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _quantityController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedProduct;

  @override
  void dispose() {
    _clientNameController.dispose();
    _phoneController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch, // Simple ID generation
        clientName: _clientNameController.text,
        phone: _phoneController.text,
        product: _selectedProduct!,
        quantity: int.parse(_quantityController.text),
        status: 'En proceso',
        deliveryDate: _selectedDate!,
      );

      widget.onSubmit(order);
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _clientNameController,
            decoration: const InputDecoration(labelText: 'Nombre del Cliente'),
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
            items: ['Agua 500ml', 'Jugo Naranja 1L', 'Agua con gas 750ml']
                .map((product) =>
                    DropdownMenuItem(value: product, child: Text(product)))
                .toList(),
            onChanged: (value) => setState(() => _selectedProduct = value),
            validator: (value) =>
                value == null ? 'Por favor seleccione un producto' : null,
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
    );
  }
}
