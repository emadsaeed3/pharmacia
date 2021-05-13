import 'dart:async';
import 'package:pharma/components/authservice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:pharma/components/dark_theme_provider.dart';
import 'package:pharma/components/theme_data.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreferences.getTheme();
  }



  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) {
      return themeChangeProvider;
    })
    ],
    child:
    Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacia',
      home:SplashScreen(),
      theme: Styles.themeData(themeChangeProvider.darkTheme, context),
    );
    }));
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}




class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () =>  Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>  AuthService().handleAuth())));
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(image: DecorationImage(
                image: AssetImage("images/wallpaper.png"),
                fit: BoxFit.cover
            )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/pharmacia_logo.png', height: size.height * 0.30  ),
                      SizedBox(height: size.height * 0.01),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}