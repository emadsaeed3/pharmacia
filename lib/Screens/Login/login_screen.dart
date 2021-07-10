import 'package:flutter/material.dart';
import 'package:pharma/Screens/Forget_Password/forgot_password_screen.dart';
import 'package:pharma/Screens/Signup/signup_screen.dart';
import 'package:pharma/components/authservice.dart';
import 'package:pharma/components/custom_surfix_icon.dart';
import '../../constants.dart';
import '../../size_config.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  bool remember = false;
  final formKey = new GlobalKey<FormState>();
   String email, password;
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;}
    return false;}
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else return null;}

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
            child: Form(key: formKey, child: _buildLoginForm())));}
   _buildLoginForm(){
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          SizedBox(height: 75.0),
          Container(height: 60.0,
            child: Stack(
              children: [
                Text('   Welcome Back !',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.safeBlockHorizontal * 40,
                  fontWeight: FontWeight.bold,)),],)),
          SizedBox(height: 5.0),
          Container(padding:
              EdgeInsets.symmetric(horizontal: 80),
              height: 80.0,
              child: Stack(
                  children: [
                  Text( "Sign in with your email and password or continue with social media",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0,color: Colors.black54,)),],)),
          SizedBox(height: 30.0),
          TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                labelText: 'EMAIL',
                hintText: "Enter your email",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "icons/Mail.svg"),
                labelStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.black.withOpacity(0.5)),),
                onChanged: (value){
                this.email = value;},
            validator: (value) => value.isEmpty ? 'Email is required': validateEmail(value)),
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
                obscureText: true, onChanged: (value){this.password  = value;},
              validator: (value) => value.isEmpty ? 'Password  is required':null),
          Row(children: [Checkbox(value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {setState(() {remember = value;});},),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                {return ResetPassword();})),
                child: Text("Forgot Password", style: TextStyle(decoration: TextDecoration.underline),),)],),
          SizedBox(height: SizeConfig.safeBlockVertical * 20),
          Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(child: GestureDetector(
                      onTap: (){signIn(email, password, context);},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 11),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                          color: kPrimaryColor,),
                        child: Row(
                          children: <Widget>[
                            Text("LOG IN", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)],),),),),],),
          SizedBox(height: SizeConfig.safeBlockVertical * 10),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: GestureDetector(
                  onTap: (){AuthService().fbSignIn(context);},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      color:kPrimaryColor),
                    child: Row(
                      children: <Widget>[
                        Center(
                            child: ImageIcon(AssetImage('assets/facebook.png'), size: 18.0)),
                        SizedBox(width: 10.0),
                        Text("Login with facebook", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),],),),),),],),
          SizedBox(height: SizeConfig.safeBlockVertical * 10),
          SizedBox(height: SizeConfig.safeBlockVertical * 20),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Don’t have an account? ", style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12),),
            SizedBox(width: 5.0),
            GestureDetector(
              onTap: () =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return SignUpForm();})),
              child: Text("Sign Up", style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 12, color: kPrimaryColor),),),],)]),);}}





