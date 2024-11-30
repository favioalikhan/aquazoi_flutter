// lib/app/configuration/employees/add_empleado_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/rol_model.dart';
import '../../../../../domain/entities/employee.dart';
import 'add_employee_controller.dart';

class AddEmpleadoView extends CleanView {
  const AddEmpleadoView({super.key});

  @override
  AddEmpleadoViewState createState() => AddEmpleadoViewState();
}

class AddEmpleadoViewState
    extends CleanViewState<AddEmpleadoView, AddEmpleadoController> {
  AddEmpleadoViewState() : super(AddEmpleadoController());
  final _formKey = GlobalKey<FormState>();

  // Definir los controladores de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoPaternoController =
      TextEditingController();
  final TextEditingController _apellidoMaternoController =
      TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _fechaContratacionController =
      TextEditingController();
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _estadoController =
      TextEditingController(text: 'activo');

  bool _accesoSistema = true;

  @override
  void dispose() {
    _emailController.dispose();
    _nombreController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _dniController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _fechaContratacionController.dispose();
    _puestoController.dispose();
    _estadoController.dispose();
    super.dispose();
  }

  void _onSubmit(AddEmpleadoController controller) {
    if (_formKey.currentState!.validate()) {
      final empleado = Empleado(
        id: 0, // Este valor será ignorado por el backend
        nombre: _nombreController.text,
        apellidoPaterno: _apellidoPaternoController.text,
        apellidoMaterno: _apellidoMaternoController.text,
        email: _emailController.text,
        telefono: _telefonoController.text.isNotEmpty
            ? _telefonoController.text
            : null,
        direccion: _direccionController.text.isNotEmpty
            ? _direccionController.text
            : null,
        fechaContratacion: _fechaContratacionController.text.isNotEmpty
            ? DateTime.parse(_fechaContratacionController.text)
            : null,
        puesto: _puestoController.text,
        estado: _estadoController.text,
        departamentoPrincipal: controller.departamentoSeleccionado?.toString(),
        accesoSistema: _accesoSistema,
        roles: [], // Se manejarán en una actualización separada
        rolPrincipal: controller.rolPrincipalSeleccionado,
      );

      controller.addEmpleado(empleado);
    }
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<AddEmpleadoController>(
      builder: (context, controller) {
        return Material(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text('Registro de Empleados',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Información Personal
                        Text('Información Personal',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nombreController,
                          decoration:
                              const InputDecoration(labelText: 'Nombre'),
                          validator: (value) => value!.isEmpty
                              ? 'Por favor ingrese el nombre'
                              : null,
                        ),
                        TextFormField(
                          controller: _apellidoPaternoController,
                          decoration: const InputDecoration(
                              labelText: 'Apellido Paterno'),
                          validator: (value) => value!.isEmpty
                              ? 'Por favor ingrese el apellido paterno'
                              : null,
                        ),
                        TextFormField(
                          controller: _apellidoMaternoController,
                          decoration: const InputDecoration(
                              labelText: 'Apellido Materno'),
                          validator: (value) => value!.isEmpty
                              ? 'Por favor ingrese el apellido materno'
                              : null,
                        ),
                        TextFormField(
                          controller: _dniController,
                          decoration: const InputDecoration(labelText: 'DNI'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese el DNI';
                            }
                            if (value.length != 8) {
                              return 'El DNI debe tener 8 dígitos';
                            }
                            return null;
                          },
                        ),

                        // Información de Contacto
                        const SizedBox(height: 16),
                        Text('Información de Contacto',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Por favor ingrese un email válido';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _telefonoController,
                          decoration:
                              const InputDecoration(labelText: 'Teléfono'),
                          keyboardType: TextInputType.phone,
                        ),
                        TextFormField(
                          controller: _direccionController,
                          decoration:
                              const InputDecoration(labelText: 'Dirección'),
                          maxLines: 2,
                        ),

                        // Información Laboral
                        const SizedBox(height: 16),
                        Text('Información Laboral',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _fechaContratacionController,
                          decoration: const InputDecoration(
                            labelText: 'Fecha de Contratación',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () async {
                            final fecha = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (fecha != null) {
                              _fechaContratacionController.text =
                                  DateFormat('yyyy-MM-dd').format(fecha);
                            }
                          },
                          validator: (value) => value!.isEmpty
                              ? 'Por favor seleccione la fecha'
                              : null,
                        ),
                        TextFormField(
                          controller: _puestoController,
                          decoration:
                              const InputDecoration(labelText: 'Puesto'),
                          validator: (value) => value!.isEmpty
                              ? 'Por favor ingrese el puesto'
                              : null,
                        ),
                        DropdownButtonFormField<String>(
                          value: _estadoController.text,
                          decoration:
                              const InputDecoration(labelText: 'Estado'),
                          items: const [
                            DropdownMenuItem(
                                value: 'activo', child: Text('Activo')),
                            DropdownMenuItem(
                                value: 'inactivo', child: Text('Inactivo')),
                            DropdownMenuItem(
                                value: 'licencia', child: Text('Licencia')),
                            DropdownMenuItem(
                                value: 'retirado', child: Text('Retirado')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              _estadoController.text = value;
                            }
                          },
                        ),

                        // Información Organizacional
                        const SizedBox(height: 16),
                        Text('Información Organizacional',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<int>(
                          value: controller.departamentoSeleccionado,
                          decoration: const InputDecoration(
                            labelText: 'Departamento Principal',
                          ),
                          items: controller.departamentos.map((departamento) {
                            return DropdownMenuItem(
                              value: departamento.id,
                              child: Text(departamento.nombre),
                            );
                          }).toList(),
                          onChanged: controller.onDepartamentoChanged,
                          validator: (value) => value == null
                              ? 'Por favor seleccione un departamento'
                              : null,
                        ),
                        DropdownButtonFormField<RolDetailModel>(
                          value: controller.rolPrincipalSeleccionado,
                          decoration: const InputDecoration(
                            labelText: 'Rol Principal',
                          ),
                          items: controller.rolesDisponibles.isNotEmpty
                              ? controller.rolesDisponibles.map((rol) {
                                  return DropdownMenuItem(
                                    value: rol,
                                    child: Text(rol.nombre),
                                  );
                                }).toList()
                              : [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('No hay roles disponibles'),
                                  )
                                ],
                          onChanged: controller.onRolPrincipalChanged,
                          validator: (value) => value == null
                              ? 'Por favor seleccione un rol principal'
                              : null,
                        ),
                        CheckboxListTile(
                          title: const Text('Requiere acceso al sistema'),
                          value: _accesoSistema,
                          onChanged: (bool? value) {
                            setState(() {
                              _accesoSistema = value ?? false;
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _onSubmit(controller),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text('Registrar Empleado'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
