import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma/components/bottom_nav_bar.dart';
import '../../constants.dart';
import '../Carts/cart.dart';
import '../pres_upload.dart';
import '../user_info.dart';
import 'menu_dashboard_layout.dart';




class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int selectedIndex = 0;
  final screen = [ MenuDashboardPage(), PreUpload(), Cart(), UserInfo()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: kPrimaryColor,
        backgroundColor: Theme.of(context).primaryColor,
        buttonBackgroundColor: kPrimaryColor,
        index: selectedIndex,
        key: NavbarKey.getKey(),
        items: <Widget>[
          Icon(Icons.home, size: 15,color: Colors.white),
          Icon(CupertinoIcons.camera_fill, size: 15,color: Colors.white,),
          Icon(Icons.shopping_cart, size: 15,color: Colors.white),
          Icon(Icons.person, size: 15,color: Colors.white)
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
