import 'package:flutter/material.dart';

import 'pages/configuration/configuration_page.dart';

class BottomNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onPageChanged;

  const BottomNavbar({
    required this.currentIndex,
    required this.onPageChanged,
    super.key,
  });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  //int _selectedIndex = 0;

  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Inicio',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Ventas',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.inventory),
      label: 'Inventario',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Clientes',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz),
      label: 'Más',
    ),
  ];

  void _onItemTapped(int index) {
    if (index == _navItems.length - 1) {
      _showMoreSheet();
    } else {
      widget.onPageChanged(index);
    }
  }

  void _showMoreSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 330,
          child: Column(
            children: [
              const ListTile(
                title: Text('Menú de Zoi Aqua'),
                subtitle: Text(
                    'Accede a más funciones y configuraciones de la aplicación.'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configuración'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfigurationPage()),
                  );
                  // Navegar a la página de configuración
                },
              ),
              ListTile(
                leading: const Icon(Icons.assessment),
                title: const Text('Reportes'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar a la página de reportes
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Ayuda'),
                onTap: () {
                  Navigator.pop(context);
                  // Navegar a la página de ayuda
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text('Cerrar Sesión',
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  // Lógica para cerrar sesión
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _navItems,
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
    );
  }
}
