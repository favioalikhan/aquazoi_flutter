// lib/app/configuration/employees/employees_view.dart
import 'package:aquazoi/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/usecases/employees/get_employees_usecase.dart';
import 'employee_controller.dart';
import 'employee_presenter.dart';

class EmpleadosView extends CleanView {
  final GetEmpleadosUseCase getEmpleadosUseCase;

  const EmpleadosView(this.getEmpleadosUseCase, {super.key});

  @override
  State<StatefulWidget> createState() => _EmpleadosViewState();
}

class _EmpleadosViewState
    extends CleanViewState<EmpleadosView, EmpleadosController> {
  _EmpleadosViewState()
      : super(EmpleadosController(
          EmpleadosPresenter(
            GetEmpleadosUseCase(sl()), // Conecta con tu repositorio
          ),
        ));

  @override
  Widget get view {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empleados'),
        actions: [
          // Use ControlledWidgetBuilder to access controller
          ControlledWidgetBuilder<EmpleadosController>(
            builder: (context, controller) => IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // Now 'controller' is correctly defined
                controller.fetchEmpleados();
              },
            ),
          ),
        ],
      ),
      body: ControlledWidgetBuilder<EmpleadosController>(
        builder: (context, controller) {
          if (controller.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando empleados...'),
                ],
              ),
            );
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          if (controller.empleados.isEmpty) {
            return const Center(child: Text('No hay empleados disponibles.'));
          }

          return ListView.builder(
            itemCount: controller.empleados.length,
            itemBuilder: (context, index) {
              final empleado = controller.empleados[index];
              return ListTile(
                title: Text('${empleado.nombre} ${empleado.apellidoPaterno}'),
                subtitle: Text(empleado.puesto ?? 'Sin puesto asignado'),
              );
            },
          );
        },
      ),
    );
  }
}
