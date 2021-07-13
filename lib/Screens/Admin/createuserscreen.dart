import 'package:flutter/material.dart';
import 'package:pharma/components/authservice.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class CreateUser extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CreateUser> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/wallpaper.png"),
                fit: BoxFit.cover,),),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _createAdminForm())));}
  _createAdminForm(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                  30.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "Name",
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                  30.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "Email",
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                  30.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "Password",),),
          SizedBox(height: 20),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                  30.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "Phone",
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: roleController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                  30.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "Role",
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              String name = nameController.text.trim();
              String email = emailController.text.trim();
              String password = passwordController.text.trim();
              String phone = phoneController.text.trim();
              String role = roleController.text.trim();
              context.read<AuthService>().signUp(name,email, password,phone, role);},
            child: Container(
              width: 260,
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: kPrimaryColor,),
              child: Center(
                child: Text(
                  "Create User", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17)
                ),
              ),
            ),
          ),
        ],
    );
  }
}