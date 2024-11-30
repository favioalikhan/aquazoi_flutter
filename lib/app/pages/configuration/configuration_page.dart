// lib/app/modules/configuration/configuration_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:http/http.dart' as http;

import '../../../data/repositories/employee/data_employee_repository.dart';
import '../../../domain/usecases/employees/get_employees_usecase.dart';
import 'employee/employee_view.dart';

class ConfigurationPage extends CleanView {
  const ConfigurationPage({super.key});

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState
    extends CleanViewState<ConfigurationPage, ConfigurationController>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  _ConfigurationPageState() : super(ConfigurationController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = TabController(length: 1, vsync: this);
  }

  final getEmpleadosUseCase =
      GetEmpleadosUseCase(DataEmpleadoRepository(client: http.Client()));

  @override
  Widget get view {
    return Scaffold(
      key: globalKey, // Necesario para obtener el contexto en el controlador
      appBar: AppBar(
        title: const Text('Módulo de Configuración'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Empleados'),
            //Tab(text: 'Productos'),
            //Tab(text: 'Rutas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          EmpleadosView(getEmpleadosUseCase),
          // ProductsView(),
          // RoutesView(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class ConfigurationController extends Controller {
  @override
  void initListeners() {
    // Aquí puedes inicializar los listeners si es necesario
  }
}
