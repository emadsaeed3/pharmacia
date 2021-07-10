import 'package:flutter/material.dart';
import 'package:pharma/Screens/Login/login_screen.dart';
import 'package:pharma/Screens/Signup/signup_screen.dart';
import '../../constants.dart';
import '../../size_config.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),);}}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/wallpaper2.png"),
              fit: BoxFit.cover)),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,],),);}}
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Background(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/pharmacia_logo.png', height: size.height * 0.35),
                  SizedBox(height: size.height * 0.01),],),),),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();},));},
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 60, vertical: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: kPrimaryColor,),
                      child: Row(
                        children: <Widget>[
                          Text("LOG IN",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
                          SizedBox(width: 10),],),),),),
                SizedBox(height: size.height * 0.02),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SignUpForm();},));},
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 60, vertical: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: kPrimaryColor,),
                      child: Row(
                        children: <Widget>[
                          Text("SIGN UP",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),],),),),),],),),
          SizedBox(height: 40),
          Text('V 1.0', textAlign: TextAlign.center, style: Theme.of(context).textTheme.caption,),
          SizedBox(height: SizeConfig.screenHeight * 0.05),],),);}}





