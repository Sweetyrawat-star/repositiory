
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class UserPreferences {

  static Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
