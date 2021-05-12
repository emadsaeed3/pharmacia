import 'package:flutter/material.dart';
import 'package:pharma/size_config.dart';
import 'package:pharma/Screens/OTP/components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("OTP Verification" , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black)), backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),

      body: Body(),
    );
  }
}