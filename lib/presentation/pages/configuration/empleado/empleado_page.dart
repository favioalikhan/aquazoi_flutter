import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositories/data/departamento/departamento_repository.dart';
import '../../../../repositories/data/departamento/departamento_repository_impl.dart';
import '../../../../repositories/data/empleado/empleado_repository_impl.dart';
import '../../../../repositories/data/rol/rol_repository.dart';
import '../../../../repositories/data/rol/rol_repository_impl.dart';
import '../../../../services/api/api_client.dart';
import '../../../../usecases/empleado/empleado_usecase.dart';
import '../../../bloc/empleado/empleado_bloc.dart';
import 'add/add_empleado_page.dart';

class EmpleadoPage extends StatelessWidget {
  const EmpleadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmpleadoBloc(
        EmpleadoUseCase(EmpleadoRepositoryImpl(ApiClient())),
      )..add(FetchEmpleadosEvent()), // Fetch empleados when bloc is created
      child: Scaffold(
        body: const EmpleadoTable(),
      ),
    );
  }
}

class EmpleadoTable extends StatelessWidget {
  const EmpleadoTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmpleadoBloc, EmpleadoState>(
      builder: (context, state) {
        if (state is EmpleadoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EmpleadosLoadedState) {
          final empleados = state.empleados;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gestión de Empleados',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Builder(
                    builder: (context) => ElevatedButton.icon(
                      onPressed: () {
                        final empleadoBloc = context.read<EmpleadoBloc>();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MultiRepositoryProvider(
                              providers: [
                                RepositoryProvider<DepartamentoRepository>(
                                  create: (context) =>
                                      DepartamentoRepositoryImpl(ApiClient()),
                                ),
                                RepositoryProvider<RolRepository>(
                                  create: (context) =>
                                      RolRepositoryImpl(ApiClient()),
                                ),
                              ],
                              child: BlocProvider.value(
                                value: empleadoBloc,
                                child: const AddEmpleadoPage(),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text('Agregar empleado'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Apellido Paterno')),
                        DataColumn(label: Text('DNI')),
                        DataColumn(label: Text('Teléfono')),
                        DataColumn(label: Text('Puesto')),
                        DataColumn(label: Text('Departamento')),
                        DataColumn(label: Text('Rol Principal')),
                        DataColumn(label: Text('Acceso Sistema')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: empleados.map((empleado) {
                        return DataRow(
                          cells: [
                            DataCell(Text(empleado.nombre)),
                            DataCell(Text(empleado.apellidoPaterno)),
                            DataCell(Text(empleado.dni)),
                            DataCell(
                                Text(empleado.telefono ?? 'No registrado')),
                            DataCell(Text(empleado.puesto)),
                            DataCell(Text(
                                empleado.departamentoPrincipal?.nombre ??
                                    'Sin departamento')),
                            DataCell(Text(empleado.rolPrincipal?.nombre ??
                                'Sin rol principal')),
                            DataCell(
                              Icon(
                                empleado.accesoSistema
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: empleado.accesoSistema
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    // Aquí puedes agregar lógica para editar
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    context
                                        .read<EmpleadoBloc>()
                                        .add(DeleteEmpleadoEvent(empleado));
                                  },
                                ),
                              ],
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is EmpleadoFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return const Center(child: Text('No hay empleados para mostrar'));
      },
    );
  }
}
