import 'package:flutter/material.dart';
import 'package:pharma/components/authservice.dart';
import 'package:provider/provider.dart';

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          TextFormField(
            controller: roleController,
            decoration: InputDecoration(
              hintText: "Role",
            ),
          ),
          GestureDetector(
            onTap: () async {
              String name = nameController.text.trim();
              String email = emailController.text.trim();
              String password = passwordController.text.trim();
              String phone = phoneController.text.trim();
              String role = roleController.text.trim();

              context.read<AuthService>().signUp(name,email, password,phone, role);
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Create User",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}