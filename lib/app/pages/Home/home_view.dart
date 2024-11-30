import 'package:flutter/material.dart';

import '../../../presentation/pages/clients/customer_module.dart';
import '../../../presentation/pages/inventory/inventory_module.dart';
import '../../../presentation/pages/sales/sales_module.dart';
import '../../navigator.dart';
import 'dashboard_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  // Lista de páginas
  final List<Widget> _pages = [
    const DashboardView(), // Pantalla principal del dashboard
    const SalesModule(),
    const InventoryModule(),
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
