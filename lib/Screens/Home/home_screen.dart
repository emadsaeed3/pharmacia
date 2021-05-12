import 'package:flutter/material.dart';
import 'package:pharma/components/bottom_nav_bar.dart';
import 'menu_dashboard_layout.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: MenuDashboardPage(),
    );
  }
}



