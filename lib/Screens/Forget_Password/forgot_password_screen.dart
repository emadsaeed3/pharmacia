import 'package:flutter/material.dart';
import 'package:pharma/components/authservice.dart';
import 'package:pharma/components/custom_surfix_icon.dart';

import '../../constants.dart';
import '../../size_config.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = new GlobalKey<FormState>();

  String email;

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/wallpaper.png"),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildResetForm())));
  }

  _buildResetForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 120.0),
          Container(
              height: 60.0,
              child: Stack(
                children: [
                  Text('   Forgot Password',
                      style: TextStyle(color: Colors.black,
                        fontSize: SizeConfig.safeBlockHorizontal * 40,
                        fontWeight: FontWeight.bold,)),],)),
          SizedBox(height: 5.0),
          Container(
              padding:
              EdgeInsets.symmetric(horizontal: 80),
              height: 80.0,
              child: Stack(
                children: [
                  Text( "Please enter your email and we will send you a link to return to your account",textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0,color: Colors.black54)),],)),

          TextFormField(
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                hintText: "Enter your email",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "icons/Mail.svg"),
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black.withOpacity(0.5)),),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) =>
              value.isEmpty ? 'Email is required' : validateEmail(value)),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields()) AuthService().resetPasswordLink(email);
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: Color(0xFF225602),
                    elevation: 7.0,
                    child: Center(
                        child: Text('RESET',
                            style: TextStyle(
                                color: Colors.white))))),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back',
                    style: TextStyle(
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline)))
          ])
        ]));
  }
}