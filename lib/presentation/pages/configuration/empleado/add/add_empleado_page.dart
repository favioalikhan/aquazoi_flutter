import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../models/data_model/departamento_model.dart';
import '../../../../../models/data_model/empleado_model.dart';
import '../../../../../models/data_model/rol_model.dart';
import '../../../../../repositories/data/departamento/departamento_repository.dart';
import '../../../../../repositories/data/rol/rol_repository.dart';
import '../../../../bloc/empleado/empleado_bloc.dart';
import '../../../../widgets/form_widgets.dart';

class AddEmpleadoPage extends StatefulWidget {
  const AddEmpleadoPage({super.key});

  @override
  _AddEmpleadoPageState createState() => _AddEmpleadoPageState();
}

class _AddEmpleadoPageState extends State<AddEmpleadoPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto
  final _nombreController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _dniController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _fechaContratacionController = TextEditingController();
  final _fechaIngresoController = TextEditingController();
  final _fechaBajaController = TextEditingController();
  final _puestoController = TextEditingController();
  final _estadoController = TextEditingController(text: 'activo');

  // Variables de estado
  DepartamentoModel? _departamentoSeleccionado;
  List<DepartamentoModel> _departamentos = [];
  RolModel? _rolSeleccionado;
  List<RolModel> _rolesDisponibles = [];
  bool _accesoSistema = false;

  @override
  void initState() {
    super.initState();
    _cargarDepartamentos();
  }

  void _cargarDepartamentos() async {
    try {
      final departamentosRepository = context.read<DepartamentoRepository>();
      final departamentos = await departamentosRepository.getDepartamentos();
      setState(() {
        _departamentos = departamentos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar departamentos: $e')),
      );
    }
  }

  void _cargarRoles(int departamentoId) async {
    try {
      final rolRepository = context.read<RolRepository>();
      final roles = await rolRepository.getRoles(
        RolModel(departamentoId: departamentoId),
      );
      setState(() {
        _rolesDisponibles = roles;
        _rolSeleccionado = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar roles: $e')),
      );
    }
  }

  void _onDepartamentoChanged(DepartamentoModel? departamento) {
    if (departamento != null) {
      setState(() {
        _departamentoSeleccionado = departamento;
        _cargarRoles(departamento.id);
      });
    }
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final empleado = EmpleadoModel(
        nombre: _nombreController.text,
        apellidoPaterno: _apellidoPaternoController.text,
        apellidoMaterno: _apellidoMaternoController.text,
        dni: _dniController.text,
        email: _emailController.text,
        telefono: _telefonoController.text,
        direccion: _direccionController.text,
        fechaContratacion:
            DateTime.tryParse(_fechaContratacionController.text) ??
                DateTime.now(), // Parse to DateTime
        fechaIngreso:
            DateTime.tryParse(_fechaIngresoController.text) ?? DateTime.now(),
        fechaBaja: DateTime.tryParse(_fechaBajaController.text) ??
            DateTime.now(), // Optional field
        puesto: _puestoController.text,
        estado: _estadoController.text,
        departamentoPrincipal: _departamentoSeleccionado,
        rolPrincipal: _rolSeleccionado,
        accesoSistema: _accesoSistema,
      );

      context.read<EmpleadoBloc>().add(AddEmpleadoEvent(empleado));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar Nuevo Empleado',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: BlocListener<EmpleadoBloc, EmpleadoState>(
        listener: (context, state) {
          if (state is EmpleadoOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Empleado ${state.empleado.nombre} registrado exitosamente'),
                backgroundColor: Colors.green,
              ),
            );
            context.read<EmpleadoBloc>().add(FetchEmpleadosEvent());
            Navigator.of(context).pop();
          } else if (state is EmpleadoFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registro de Empleados',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),

                // Información Personal
                Text(
                  'Información Personal',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _nombreController,
                  labelText: 'Nombre',
                  validator: (value) =>
                      value!.isEmpty ? 'Por favor ingrese el nombre' : null,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _apellidoPaternoController,
                  labelText: 'Apellido Paterno',
                  validator: (value) => value!.isEmpty
                      ? 'Por favor ingrese el apellido paterno'
                      : null,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _apellidoMaternoController,
                  labelText: 'Apellido Materno',
                  validator: (value) => value!.isEmpty
                      ? 'Por favor ingrese el apellido materno'
                      : null,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _dniController,
                  labelText: 'DNI',
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
                Text(
                  'Información de Contacto',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un email';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Por favor ingrese un email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _telefonoController,
                  labelText: 'Teléfono',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _direccionController,
                  labelText: 'Dirección',
                ),

                // Información Laboral
                const SizedBox(height: 16),
                Text(
                  'Información Laboral',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _fechaContratacionController,
                  labelText: 'Fecha de Contratación',
                  readOnly: true,
                  suffixIcon: const Icon(Icons.calendar_today),
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
                  validator: (value) =>
                      value!.isEmpty ? 'Por favor seleccione la fecha' : null,
                ),
                CustomFormField(
                  controller: _fechaIngresoController,
                  labelText: 'Fecha de Ingreso a la Empresa',
                  readOnly: true,
                  suffixIcon: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final fecha = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (fecha != null) {
                      _fechaIngresoController.text =
                          DateFormat('yyyy-MM-dd').format(fecha);
                    }
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Por favor seleccione la fecha' : null,
                ),
                CustomFormField(
                  controller: _fechaBajaController,
                  labelText: 'Fecha de Baja de la Empresa',
                  readOnly: true,
                  suffixIcon: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final fecha = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (fecha != null) {
                      _fechaBajaController.text =
                          DateFormat('yyyy-MM-dd').format(fecha);
                    }
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Por favor seleccione la fecha' : null,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _puestoController,
                  labelText: 'Puesto',
                  validator: (value) =>
                      value!.isEmpty ? 'Por favor ingrese el puesto' : null,
                ),
                const SizedBox(height: 8),
                CustomDropdownField<int?>(
                  value: _departamentoSeleccionado
                      ?.id, // Solo el ID, no el objeto completo
                  labelText: 'Departamento Principal',
                  items: _departamentos.map((dept) {
                    return DropdownMenuItem<int?>(
                      value: dept
                          .id, // El value es el id, pero mostramos el nombre
                      child: Text(
                          dept.nombre), // El nombre se muestra en el dropdown
                    );
                  }).toList(),
                  onChanged: (int? id) {
                    setState(() {
                      // Buscar el objeto DepartamentoModel correspondiente
                      _departamentoSeleccionado = _departamentos.firstWhere(
                        (dept) => dept.id == id,
                      );
                      // Llamar a la función _onDepartamentoChanged para cargar los roles
                      if (_departamentoSeleccionado != null) {
                        _onDepartamentoChanged(_departamentoSeleccionado);
                      }
                    });
                  },
                  validator: (value) => value == null
                      ? 'Por favor seleccione un departamento'
                      : null,
                ),
                const SizedBox(height: 8),
                CustomDropdownField<int?>(
                  value: _rolSeleccionado
                      ?.id, // Aquí el valor debería ser el ID del rol
                  labelText: 'Rol Principal',
                  items: _rolesDisponibles.map((rol) {
                    return DropdownMenuItem<int?>(
                      value: rol.id, // El value debe ser el ID del rol
                      child: Text(rol.nombre ?? 'Sin Rol'),
                    );
                  }).toList(),
                  onChanged: (int? id) {
                    setState(() {
                      // Cuando el valor cambia, buscamos el objeto RolModel correspondiente
                      _rolSeleccionado = _rolesDisponibles.firstWhere(
                        (rol) => rol.id == id,
                      );
                    });
                  },
                  validator: (value) => value == null
                      ? 'Por favor seleccione un rol principal'
                      : null,
                ),
                const SizedBox(height: 8),
                SystemAccessSwitch(
                  value: _accesoSistema,
                  onChanged: (value) => setState(() {
                    _accesoSistema = value;
                  }),
                ),
                const SizedBox(height: 24),
                SubmitButton(
                  onPressed: _onSubmit,
                  text: 'Registrar Empleado',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Liberar recursos
    _nombreController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _dniController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _fechaContratacionController.dispose();
    _puestoController.dispose();
    _estadoController.dispose();
    super.dispose();
  }
}
