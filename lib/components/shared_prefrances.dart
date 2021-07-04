import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences;

Future<void> initpref() async {
  preferences = await SharedPreferences.getInstance();
}

Future<bool> saveToken(String orderIndex) => preferences.setString('orderIndex', orderIndex);

Future<bool> removeToken() => preferences.remove('orderIndex');

String getToken() => preferences.getString('orderIndex');