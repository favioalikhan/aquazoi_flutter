// update_empleado_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../models/data_model/empleado_model.dart';
import '../../../../bloc/empleado/empleado_bloc.dart';
import '../../../../bloc/empleado/empleado_event.dart'; // Para formatear fechas

class UpdateEmpleadoPage extends StatefulWidget {
  final EmpleadoModel empleado;

  const UpdateEmpleadoPage({super.key, required this.empleado});

  @override
  UpdateEmpleadoPageState createState() => UpdateEmpleadoPageState();
}

class UpdateEmpleadoPageState extends State<UpdateEmpleadoPage> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;
  late String _apellidoPaterno;
  late String _apellidoMaterno;
  late String _dni;
  String? _telefono;
  String? _direccion;
  DateTime? _fechaContratacion;
  DateTime? _fechaIngreso;
  DateTime? _fechaBaja;
  late String _puesto;
  bool _accesoSistema = false;

  @override
  void initState() {
    super.initState();
    _nombre = widget.empleado.nombre ?? '';
    _apellidoPaterno = widget.empleado.apellidoPaterno ?? '';
    _apellidoMaterno = widget.empleado.apellidoMaterno ?? '';
    _dni = widget.empleado.dni;
    _telefono = widget.empleado.telefono;
    _direccion = widget.empleado.direccion;
    _fechaContratacion = widget.empleado.fechaContratacion;
    _fechaIngreso = widget.empleado.fechaIngreso;
    _fechaBaja = widget.empleado.fechaBaja;
    _puesto = widget.empleado.puesto;
    _accesoSistema = widget.empleado.accesoSistema;
  }

  Future<void> _selectDate(BuildContext context, bool isContratacion) async {
    DateTime initialDate = isContratacion
        ? (_fechaContratacion ?? DateTime.now())
        : (_fechaIngreso ?? DateTime.now());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        if (isContratacion) {
          _fechaContratacion = picked;
        } else {
          _fechaIngreso = picked;
        }
      });
    }
  }

  Future<void> _selectFechaBaja(BuildContext context) async {
    DateTime initialDate = _fechaBaja ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: _fechaIngreso ?? DateTime(1900, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        _fechaBaja = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final empleadoBloc = context.read<EmpleadoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Empleado'),
      ),
      body: SingleChildScrollView(
        // Para evitar overflow en pantallas pequeñas
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nombre
              TextFormField(
                initialValue: widget.empleado.id?.toString() ?? '',
                decoration: const InputDecoration(labelText: 'ID'),
                readOnly: true,
              ),
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese el nombre' : null,
                onSaved: (value) => _nombre = value!,
              ),
              // Apellido Paterno
              TextFormField(
                initialValue: _apellidoPaterno,
                decoration:
                    const InputDecoration(labelText: 'Apellido Paterno'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese el apellido paterno'
                    : null,
                onSaved: (value) => _apellidoPaterno = value!,
              ),
              // Apellido Materno
              TextFormField(
                initialValue: _apellidoMaterno,
                decoration:
                    const InputDecoration(labelText: 'Apellido Materno'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese el apellido materno'
                    : null,
                onSaved: (value) => _apellidoMaterno = value!,
              ),
              // DNI
              TextFormField(
                initialValue: _dni,
                decoration: const InputDecoration(labelText: 'DNI'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese el DNI' : null,
                onSaved: (value) => _dni = value!,
              ),
              // Teléfono
              TextFormField(
                initialValue: _telefono,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                onSaved: (value) => _telefono = value,
              ),
              // Dirección
              TextFormField(
                initialValue: _direccion,
                decoration: const InputDecoration(labelText: 'Dirección'),
                onSaved: (value) => _direccion = value,
              ),
              // Fecha Contratación
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _fechaContratacion != null
                          ? 'Fecha Contratación: ${DateFormat('yyyy-MM-dd').format(_fechaContratacion!)}'
                          : 'Fecha Contratación: No seleccionada',
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context, true),
                    child: const Text('Seleccionar'),
                  ),
                ],
              ),
              // Fecha Ingreso
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _fechaIngreso != null
                          ? 'Fecha Ingreso: ${DateFormat('yyyy-MM-dd').format(_fechaIngreso!)}'
                          : 'Fecha Ingreso: No seleccionada',
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context, false),
                    child: const Text('Seleccionar'),
                  ),
                ],
              ),
              // Fecha Baja
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _fechaBaja != null
                          ? 'Fecha Baja: ${DateFormat('yyyy-MM-dd').format(_fechaBaja!)}'
                          : 'Fecha Baja: No seleccionada',
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectFechaBaja(context),
                    child: const Text('Seleccionar'),
                  ),
                ],
              ),
              // Puesto
              TextFormField(
                initialValue: _puesto,
                decoration: const InputDecoration(labelText: 'Puesto'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese el puesto' : null,
                onSaved: (value) => _puesto = value!,
              ),
              // Estado

              // Departamento Principal

              // Acceso Sistema
              SwitchListTile(
                title: const Text('Acceso al Sistema'),
                value: _accesoSistema,
                onChanged: (bool value) {
                  setState(() {
                    _accesoSistema = value;
                  });
                },
              ),
              // Rol Principal

              // Roles Adicionales

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final empleadoActualizado = EmpleadoModel(
                      id: widget.empleado.id, // Keep original ID
                      email: widget.empleado.email,
                      nombre: _nombre, // Use form-updated values
                      apellidoPaterno: _apellidoPaterno,
                      apellidoMaterno: _apellidoMaterno,
                      dni: _dni,
                      telefono: _telefono,
                      direccion: _direccion,
                      fechaContratacion: _fechaContratacion,
                      fechaIngreso: _fechaIngreso,
                      fechaBaja: _fechaBaja,
                      puesto: _puesto,
                      estado: widget.empleado.estado,
                      departamentoPrincipal:
                          widget.empleado.departamentoPrincipal,
                      accesoSistema: _accesoSistema,
                      rolPrincipal: widget.empleado.rolPrincipal,
                      roles: widget.empleado.roles,
                    );

                    empleadoBloc.add(UpdateEmpleadoEvent(
                        // Safely handle potential null ID
                        widget.empleado.id!,
                        empleadoActualizado));

                    Navigator.pop(context, true);
                  }
                },
                child: const Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
