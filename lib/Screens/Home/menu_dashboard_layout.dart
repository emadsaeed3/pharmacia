import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma/Screens/Home/cubit/cubit.dart';
import 'package:pharma/Screens/Home/cubit/state.dart';
import 'package:pharma/Screens/confirmation/confirmation_screen.dart';
import 'package:pharma/Screens/orders/orders_screen.dart';
import 'package:pharma/Screens/pres_upload.dart';
import 'package:pharma/components/authservice.dart';
import 'package:pharma/components/build_progress.dart';
import 'package:pharma/components/navigations.dart';
import 'package:pharma/components/ratingWidget.dart';
import 'package:pharma/components/search_bar.dart';
import 'package:pharma/components/shared_prefrances.dart';
import '../../constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MenuDashboardPage extends StatefulWidget {
  static String routeName = "/home";

  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> with SingleTickerProviderStateMixin {

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  final padding = EdgeInsets.symmetric(horizontal: 20);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return BlocProvider(
      create: (context) => AllPharmaciesCubit()..allPharmacies(),
      child: BlocConsumer<AllPharmaciesCubit, AllPharmaciesStates>(
        listener: (context, state) {
          if (state is AllPharmaciesStateLoading) {
            print('SignUpStateLoading');
            return buildProgress(
                context: context,
                text: "please Wait until creating an account.. ");
          }
          if (state is AllPharmaciesStateSuccess) {
            print('SignUpStateSuccess');
          }
          if (state is AllPharmaciesStateError) {
            print('SignUpStateError');
            Navigator.pop(context);
            return buildProgress(
              context: context,
              text: "${state.error.toString()}",
              error: true,
            );
          }
        },
        builder: (context, state) {
          List pharmacies = AllPharmaciesCubit.get(context).pharmacies;
          return ConditionalBuilder(
            condition: pharmacies.length != 0,
            builder: (context) =>  Scaffold(
              backgroundColor: Theme.of(context).focusColor,
              body: Stack(
                children: <Widget>[
                  menu(context),
                  dashboard(context, pharmacies),
                ],
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );


        },
      ),
    );
  }

  Widget menu(context) {
    final name = 'Welcome,  !';
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 90),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildHeader(
                  name: name,
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.white70,
                  endIndent: 200,
                ),
                SizedBox(height: 30),
                buildMenuItem(text: 'Orders', icon: Icons.receipt_long),
                SizedBox(height: 30),
                buildMenuItem(text: 'Wishlist', icon: Icons.favorite),
                SizedBox(height: 30),
                buildMenuItem(
                    text: 'Address Book',
                    icon: Icons.person_pin_circle_rounded),
                SizedBox(height: 30),
                buildMenuItem(text: 'Settings', icon: Icons.settings),
                SizedBox(height: 30),
                buildMenuItem(text: 'Get Help', icon: Icons.live_help),
                SizedBox(height: 30),
                buildMenuItem(
                    text: 'Confirmation',
                    icon: Icons.confirmation_num_outlined,
                    onClicked: () {
                     navigateAndFinish(context, ConfirmationScreen());
                    }),
                SizedBox(height: 30),
                Divider(
                  color: Colors.white70,
                  endIndent: 200,
                ),
                SizedBox(height: 10),
                buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () {
                      AuthService().signOut(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    String name,
  }) => InkWell(
        child: Container(
          child: Row(
            children: [
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: backgroundColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) => InkWell(
        onTap: onClicked,
        child: Container(
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ],
          ),
        ),
      );

  Widget locationItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) => InkWell(
        onTap: onClicked,
        child: Container(
          child: Row(
            children: [
              Icon(icon, color: Color(0xFF73B865), size: 20),
              SizedBox(width: 6),
              Column(
                children: [
                  Text(text,
                      style: TextStyle(color: Color(0xFF73B865), fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      );

  Widget dashboard(context, List pharmacies) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      right: isCollapsed ? 0 : -0.6 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          elevation: 8,
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Color(0xFF73B865)),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      locationItem(
                          text: _currentAddress ?? 'Location',
                          icon: Icons.refresh,
                          onClicked: () {
                            _getCurrentLocation();
                          }),
                      InkWell(
                        child:
                            Icon(Icons.shopping_cart, color: Color(0xFF73B865)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OrdersScreen();
                          }));
                        },
                      ),
                    ],
                  ),
                  SearchBar(),
                  InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFf03c2e),
                            style: BorderStyle.solid,
                            width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xfffdebeb),
                      ),
                      child: ListTile(
                        leading: new Icon(
                          Icons.warning,
                          color: Color(0xFFf03c2e),
                        ),
                        title: new Text(
                          "All patient's orders are revised, prepared and delivered by the pharmacies without Pharmacia app interference.",
                          style: TextStyle(
                              color: Color(0xFFf03c2e),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: PageView(
                      controller: PageController(viewportFraction: 1),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("images/1.png"),
                            fit: BoxFit.contain,
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("images/1.png"),
                            fit: BoxFit.contain,
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("images/1.png"),
                            fit: BoxFit.contain,
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "  Top Pharmacies",
                        style: TextStyle(
                            color: Color(0xFF73B865),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          height: 0.5,
                          color: Color(0xFFBBBBBB),
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "See More",
                          style: TextStyle(color: Color(0xFFBBBBBB)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage('${pharmacies[0]['imageLink']}'),
                        )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${pharmacies[0]['title']}',
                            style:
                                TextStyle(fontSize: 18, color: kPrimaryColor),
                          ),
                          RatingWidget(
                            rating: double.parse('${pharmacies[0]['rate']}'),
                            color: Colors.orange,
                            size: 20.0,
                          ),
                          Text('Live traking - Contactless delivery',
                              style: TextStyle(
                                  fontSize: 12, color: kPrimaryColor)),
                        ],
                      )),
                      InkWell(
                        onTap: (){
                          saveToken('0');
                          AllPharmaciesCubit.get(context).changeIndex(1);
                          navigateTo(context, PreUpload());
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              color: Color(0xFF73B865)),
                          child: Text(
                            "Order Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                      color: Colors.grey,
                      endIndent: 50,
                      height: 0.5,
                      indent: 50),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage('${pharmacies[1]['imageLink']}'),
                        )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${pharmacies[1]['title']}',
                            style:
                                TextStyle(fontSize: 18, color: kPrimaryColor),
                          ),
                          RatingWidget(
                            rating: double.parse('${pharmacies[1]['rate']}'),
                            color: Colors.orange,
                            size: 20.0,
                          ),
                          Text('Live traking - Contactless delivery',
                              style: TextStyle(
                                  fontSize: 12, color: kPrimaryColor)),
                        ],
                      )),
                      InkWell(
                        onTap: (){
                          saveToken('1');
                          AllPharmaciesCubit.get(context).changeIndex(2);
                          navigateTo(context, PreUpload());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              color: Color(0xFF73B865)),
                          child: Text(
                            "Order Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                      color: Colors.grey,
                      endIndent: 50,
                      height: 0.5,
                      indent: 50),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage('${pharmacies[2]['imageLink']}'),
                        )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${pharmacies[2]['title']}',
                            style:
                                TextStyle(fontSize: 18, color: kPrimaryColor),
                          ),
                          RatingWidget(
                            rating: double.parse('${pharmacies[2]['rate']}'),
                            color: Colors.orange,
                            size: 20.0,
                          ),
                          Text('Live traking - Contactless delivery',
                              style: TextStyle(
                                  fontSize: 12, color: kPrimaryColor)),
                        ],
                      )),

                      InkWell(
                        onTap: (){
                          saveToken('2');
                          AllPharmaciesCubit.get(context).changeIndex(3);
                          navigateTo(context, PreUpload());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              color: Color(0xFF73B865)),
                          child: Text(
                            "Order Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                               ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                      color: Colors.grey,
                      endIndent: 50,
                      height: 0.5,
                      indent: 50),
                  SizedBox(height: 10),
                  // Expanded(child:  ListView.separated(
                  //   itemBuilder: (context,index)=> Row (
                  //     children: [
                  //       Container(
                  //         height: 100,
                  //         width: 100,
                  //         decoration: BoxDecoration(
                  //             image: DecorationImage(
                  //               image: NetworkImage('${pharmacies[index]['imageLink']}'),
                  //             )
                  //         ),
                  //       ),
                  //       SizedBox(width: 10),
                  //       Expanded(child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text('${pharmacies[index]['title']}',style: TextStyle(fontSize: 18,color: kPrimaryColor),),
                  //           Row(
                  //             children: [
                  //               Icon(Icons.star, size: 20, color: Colors.orange,),
                  //               Icon(Icons.star, size: 20, color: Colors.orange,),
                  //               Icon(Icons.star, size: 20, color: Colors.orange,),
                  //               Icon(Icons.star, size: 20, color: Colors.orange,),
                  //               Icon(Icons.star, size: 20, color: Colors.orange,),
                  //             ],
                  //           ),
                  //           Text('Live traking - Contactless delivery',
                  //               style: TextStyle(fontSize: 12,color: kPrimaryColor)),
                  //         ],
                  //       )
                  //       ),
                  //       InkWell(
                  //         child: Container(
                  //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.all(Radius.circular(40)),
                  //               color: Color(0xFF73B865)
                  //           ),
                  //           child: Text("Order Now", style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w700
                  //           ),),
                  //         ),
                  //       )
                  //     ],
                  //
                  //   ),
                  //   separatorBuilder:(context,index)=> Column(
                  //     children: [
                  //       Divider(color: Colors.grey,endIndent: 50,height: 0.5,indent: 50),
                  //       SizedBox(height: 10),
                  //     ],
                  //   ),
                  //   itemCount: pharmacies.length,
                  // ), ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("  Best Selling", style: TextStyle(color: Color(0xFF73B865), fontSize: 20,fontWeight: FontWeight.bold),),
                  //     Expanded(child: Container(
                  //       margin: EdgeInsets.symmetric(horizontal: 30),
                  //       height: 0.5,
                  //       color: Color(0xFFBBBBBB),
                  //     ),
                  //     ),
                  //     GestureDetector(
                  //       child: Text(
                  //         "See More",style: TextStyle(color: Color(0xFFBBBBBB)),
                  //       ),
                  //     ),
                  //   ],
                  //
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Row (
  // children: [
  // Container(
  // height: 100,
  // width: 100,
  // decoration: BoxDecoration(
  // image: DecorationImage(
  // image: AssetImage("images/e.jpg")
  // )
  // ),
  // ),
  // SizedBox(width: 10),
  // Expanded(child: Column(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Text('El Ezaby Pharmacy',style: TextStyle(fontSize: 18,color: kPrimaryColor),),
  // Row(
  // children: [
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // ],
  // ),
  // Text('Live traking - Contactless delivery',
  // style: TextStyle(fontSize: 12,color: kPrimaryColor)),
  // ],
  // )
  // ),
  // InkWell(
  // child: Container(
  // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  // decoration: BoxDecoration(
  // borderRadius: BorderRadius.all(Radius.circular(40)),
  // color: Color(0xFF73B865)
  // ),
  // child: Text("Order Now", style: TextStyle(
  // color: Colors.white,
  // fontSize: 12,
  // fontWeight: FontWeight.w700
  // ),),
  // ),
  // )
  // ],
  //
  // ),
  // Divider(color: Colors.grey,endIndent: 50,height: 0.5,indent: 50),
  // SizedBox(height: 10),
  // Row (
  // children: [
  // Container(
  // height: 100,
  // width: 100,
  // decoration: BoxDecoration(
  // image: DecorationImage(
  // image: AssetImage("images/19011.png")
  // )
  // ),
  // ),
  // SizedBox(width: 10),
  // Expanded(child: Column(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Text('19011',style: TextStyle(fontSize: 18,color: kPrimaryColor),),
  // Row(
  // children: [
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // Icon(Icons.star, size: 20, color: Colors.orange,),
  // ],
  // ),
  // Text('Live traking - Contactless delivery',
  // style: TextStyle(fontSize: 12,color: kPrimaryColor)),
  // ],
  // )
  // ),
  // InkWell(
  // child: Container(
  // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  // decoration: BoxDecoration(
  // borderRadius: BorderRadius.all(Radius.circular(40)),
  // color: Color(0xFF73B865)
  // ),
  // child: Text("Order Now", style: TextStyle(
  // color: Colors.white,
  // fontSize: 12,
  // fontWeight: FontWeight.w700
  // ),),
  // ),
  // )
  // ],
  //
  // ),
  // SizedBox(height: 10),
  // Divider(color: Colors.grey,endIndent: 50,height: 0.5,indent: 50),
  // SizedBox(height: 10),

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      print('$position');
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }


}
