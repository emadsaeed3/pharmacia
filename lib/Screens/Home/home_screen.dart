import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharma/components/bottom_nav_bar.dart';
import '../cart.dart';
import '../search.dart';
import '../user_info.dart';
import 'menu_dashboard_layout.dart';




class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int selectedIndex = 0;
  final screen = [ MenuDashboardPage(), Search(), Cart(), UserInfo()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Color(0xFF73B865),
        buttonBackgroundColor: Color(0xFFF3F9F1),
        index: selectedIndex,
        key: NavbarKey.getKey(),
        items: <Widget>[
          Icon(Icons.home, size: 15,color: Color(0xFF73B865)),
          Icon(Icons.search, size: 15,color: Color(0xFF73B865),),
          Icon(Icons.shopping_cart, size: 15,color: Color(0xFF73B865)),
          Icon(Icons.person, size: 15,color: Color(0xFF73B865))
        ],
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInBack,
        animationDuration: const Duration(milliseconds: 150),
      ),
      body: screen[selectedIndex],
    );
  }
}
