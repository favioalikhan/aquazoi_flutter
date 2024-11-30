import 'package:flutter/material.dart';
//import 'package:zoiaqua/presentation/widgets/card.dart';
//import '../widgets/bottom_navbar.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;

  const DashboardLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(child: child),
            //const BottomNavbar(),
          ],
        ),
      ),
    );
  }
}
