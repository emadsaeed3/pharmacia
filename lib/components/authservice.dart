import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:pharma/Screens/Home/menu_dashboard_layout.dart';
import 'package:pharma/Screens/Welcome/welcome_screen.dart';
import 'form_error.dart';


class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MenuDashboardPage();
          } else
            return WelcomeScreen();});}

  //Sign out
  signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    });
  }


// Signup a new user
  signUp(String email, String password) async {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // final userDocument = FirebaseFirestore.instance.collection('users').doc(email).collection('password').doc(password);
    // final uesrData = (await userDocument.get()).data;
    // return uesrData;
  }








  //fb signin

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
      // Logged in

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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuDashboardPage()
        ));
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






  //Reset Password
  resetPasswordLink(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);}
}

signIn(String email, String password, context) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((val) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuDashboardPage()));
  }).catchError((e) {
    ErrorHandler().errorDialog(context, e);
  });
}








