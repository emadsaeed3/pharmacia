import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'createuserscreen.dart';
import 'edituserdata.dart';

class AdminScreen extends StatefulWidget{
  @override
  _AdminScreenState createState() => _AdminScreenState();
}


class _AdminScreenState extends State<AdminScreen> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  String email = " ";
  String name = " ";
  String password = " ";
  String phone = " ";
  String role = " ";
  String uid = " ";
  bool ableToEdit = false;

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
         child: Form(key: formKey, child: _buildAdminForm())));}
  _buildAdminForm(){
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text("Welcome Admin", style: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,)),
    SizedBox(height: 30),
    TextFormField(
    controller: emailController,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(
          30.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: "Email",
        labelStyle: TextStyle(
            fontSize: 18.0,
            color: Colors.black
                .withOpacity(0.5))
    ),
    ),
      SizedBox(height: 30),
      GestureDetector(
        onTap: () async {
          String userEmail = emailController.text.trim();
          final QuerySnapshot snap = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: userEmail).get();
          setState(() {
            email = userEmail;
            name = snap.docs[0]['name'];
            password = snap.docs[0]['password'];
            phone = snap.docs[0]['phone'];
            role = snap.docs[0]['role'];
            uid = snap.docs[0]['uid'];
            ableToEdit = true;});},
        child: Container(
          width: 250,
          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
            color: kPrimaryColor,),
          child: Center(
            child: Text(
              "Get User Data",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17)),),),),
      SizedBox(height: 30),
      ableToEdit ? GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditUser(uid: uid,)));},
        child: Container(
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
            color: kPrimaryColor,),
          child: Center(
            child: Text(
              "Edit User",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17)),),),) : Container(),
      GestureDetector(
        onTap: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUser()));},
        child: Container(
          width: 250,
          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
            color: kPrimaryColor,),
          child: Center(
            child: Text(
              "Create User", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17)),),),),
      SizedBox(height: 50,),
      Text('User Data :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
      SizedBox(height: 20,),
      Text('Email : ' + email),
      Text('Name : ' + name),
      Text('Password : ' + password),
      Text('Phone : ' + phone),
      Text('Role : ' + role),
     ],);
  }
}
