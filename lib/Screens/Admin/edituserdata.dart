import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class EditUser extends StatefulWidget {
  final String uid;

  EditUser({Key key, this.uid}) : super(key: key);
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController roleController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
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
            child: Form(key: formKey, child: _editAdminForm())));}
  _editAdminForm(){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: roleController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    30.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Role...",
                labelStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black
                        .withOpacity(0.5))
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
                hintText: "Password...",
                labelStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black
                        .withOpacity(0.5))
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () async {
              String newRole = roleController.text.trim();
              String newPassword = passwordController.text.trim();
              FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
                'role': newRole,
                'password': newPassword,
              });
            },
            child: Container(
              width: 260,
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: kPrimaryColor,),
              child: Center(
                child: Text(
                  "UPDATE DATA", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17)
                ),
              ),
            ),
          ),
        ],
    );
  }
}