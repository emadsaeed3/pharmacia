import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:pharma/Screens/Home/home_screen.dart';
import 'package:pharma/Screens/Welcome/welcome_screen.dart';
import 'form_error.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MainScreen();
          } else
            return WelcomeScreen();});}
  signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    });
  }
  signUp(String name,String email,String password,String phone,String role) async {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

  }
  fbSignIn(context) async {
    final fb = FacebookLogin();

// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

      // Check result status
      switch (res.status) {
      case FacebookLoginStatus.success:

        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        final AuthCredential authCredential =
        FacebookAuthProvider.credential(accessToken.token);
        final result =
        await FirebaseAuth.instance.signInWithCredential(authCredential);

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
        break;
      case FacebookLoginStatus.cancel:
      // User cancel log in
        break;
      case FacebookLoginStatus.error:
      // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }
  resetPasswordLink(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);}
}
signIn(String email, String password, context) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((val) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
  }).catchError((e) {
    ErrorHandler().errorDialog(context, e);
  });
}













