import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharma/Config/MyUser.dart';
import 'package:pharma/Screens/Home/home_screen.dart';
import 'package:pharma/Screens/Welcome/welcome_screen.dart';
import 'package:pharma/components/authservice.dart';
import 'package:pharma/components/custom_surfix_icon.dart';
import 'package:pharma/components/default_button.dart';
import 'package:pharma/components/form_error.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../size_config.dart';


class SignUpForm  extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = new GlobalKey<FormState>();
  String name, email, password;
  String cpassword;
  final List<String> errors = [];


  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }



  saveAccOff(MyUser user) async{
    SharedPreferences prefe = await SharedPreferences.getInstance();
    String  jsonString = converObjectToString(user);
    prefe.setString("user", jsonString);
    print("Saved Offline");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

  }


  String converObjectToString (MyUser user) {
    String json =  jsonEncode(user);
    print('This fuck is ${json}');
    return json;
  }


  saveAccOn(MyUser user){
    String userId = user.userId;
    FirebaseFirestore.instance.collection("users").doc(userId).set({
      'name': user.userName,
      'email': user.email,
      'password': user.password,
    }).then((value) {
      print('User Added');
      saveAccOff(user);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).catchError((error) => print("Error"));
  }



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
            child: Form(key: formKey, child: _buildSignupForm())));
  }

  _buildSignupForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 60.0,
              child: Stack(
                children: [
                  Text('  Register Account',
                      style: TextStyle(color: Colors.black,
                        fontSize: SizeConfig.safeBlockHorizontal * 40,
                        fontWeight: FontWeight.bold,)),],)),
          SizedBox(height: 5.0),
          Container(
              padding:
              EdgeInsets.symmetric(horizontal: 90),
              height: 80.0,
              child: Stack(
                children: [
                  Text( "Complete your details or continue with social media",textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0,color: Colors.black54)),],)),
          TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                labelText: 'Name',
                hintText: "Enter your name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "icons/person.svg"),
                labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black.withOpacity(0.5)),),
              onChanged: (value) {
                this.name = value;},
              validator: (value) =>
              value.isEmpty ? 'Name is required' : null ),
          SizedBox(height: SizeConfig.safeBlockVertical * 10),
          TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  labelText: 'EMAIL',
                  hintText: "Enter your email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: CustomSurffixIcon(svgIcon: "icons/Mail.svg"),
                  labelStyle: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black.withOpacity(0.5)),),
              onChanged: (value) {
                this.email = value;},
              validator: (value) =>
              value.isEmpty ? 'Email is required' : validateEmail(value)),
          SizedBox(height: SizeConfig.safeBlockVertical * 10),
          TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  labelText: 'PASSWORD',
                  hintText: "Enter your password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: CustomSurffixIcon(svgIcon: "icons/Lock.svg"),
                  labelStyle: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.5)),),
              obscureText: true,
              onChanged: (value) {
                this.password = value;},
              validator: (value) =>
              value.isEmpty ? 'Password is required' : null),
          SizedBox(height: SizeConfig.safeBlockVertical * 10),
          TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                labelText: 'CONFIRM PASSWORD',
                hintText: "Re-enter your password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "icons/Lock.svg"),
                labelStyle: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.5)),),
              obscureText: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: "Please Enter your password");
                } else if (value.isNotEmpty && password == cpassword) {
                  removeError(error: "Passwords don't match");
                }
                cpassword = value;
              },
            validator: (value) {
              if (value.isEmpty) {
                return "Please Enter your password";
              } else if ((password != value)) {
                return "Passwords don't match";
              }
              return null;
            },
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 10),
          DefaultButton(
              text: "SUBMIT",
              press:(){
                if (checkFields())
                  AuthService().signUp(name,email, password).then((value) {
                    // ignore: non_constant_identifier_names
                    User Fuser = FirebaseAuth.instance.currentUser;
                     String userId = Fuser.uid;
                    MyUser user = MyUser(name, email, password, userId);
                  return saveAccOn(user);
                  }).catchError((e) {
                    ErrorHandler().errorDialog(context, e);
                  });
              }
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                {
                  return WelcomeScreen();
                }
                )),
                child: Text('Go back',
                    style: TextStyle(
                        color: kPrimaryColor,
                     )))]),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          SizedBox(height: SizeConfig.safeBlockVertical *10),
          Text(
            'By continuing your confirm that you agree \nwith our Term and Condition',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          )
        ]));
  }
}