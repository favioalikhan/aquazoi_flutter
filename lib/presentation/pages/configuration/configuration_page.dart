import 'package:aquazoi/presentation/pages/configuration/empleado/empleado_page.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulo de Configuración'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Empleados'),
            Tab(text: 'Productos'),
            Tab(text: 'Rutas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          EmpleadoPage(),
          //ProductsTab(),
          //RoutesTab(),
        ],
      ),
    );
  }
}
