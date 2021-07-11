import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma/Screens/Admin/admin_screen.dart';
import 'package:pharma/components/authservice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pharma/components/navigations.dart';
import 'package:pharma/components/shared_prefrances.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initpref();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pharmacia',
            home: SplashScreen(),);}}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = 'user';
  @override
  void initState() {
    super.initState();
    _checkRole();}

  void _checkRole() async {
    User user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
     setState(() {
       role = snap['role'];
     });
     if(role == 'user'){
       Navigator.of(context).pushReplacement(MaterialPageRoute(
           builder: (BuildContext context) => AuthService().handleAuth()));
     } else if(role == 'admin'){
       navigateNext(AdminScreen());
     }
  }

  void navigateNext(Widget route) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route));
    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/wallpaper.png"),
                    fit: BoxFit.cover)),),
          Column(mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/pharmacia_logo.png',
                          height: size.height * 0.30),
                      SizedBox(height: size.height * 0.01),],),),),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),],),)],)],),);}}
