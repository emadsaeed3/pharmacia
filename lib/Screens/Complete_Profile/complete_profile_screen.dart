import 'package:flutter/material.dart';
import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Sign Up",  style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black)), backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Body(),
    );
  }
}