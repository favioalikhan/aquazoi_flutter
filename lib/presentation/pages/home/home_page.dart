import 'package:flutter/material.dart';

import '../../../presentation/pages/clients/customer_module.dart';
import '../../../presentation/pages/inventory/inventory_module.dart';
import '../inventory/control/control_page.dart';
import '../inventory/producto/producto_page.dart';
import '../../../presentation/pages/sales/sales_module.dart';
import '../../../routes/navigation.dart';
import 'dashboard/dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Lista de páginas
  final List<Widget> _pages = [
    const DashboardPage(), // Pantalla principal del dashboard
    const SalesModule(),
    const ProductoPage(),
    const CustomerModule(),
    const SizedBox(), // Página vacía para el botón "Más"
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onPageChanged: _onPageChanged,
      ),
    );
  }
}
