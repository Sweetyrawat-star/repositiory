import 'package:shared_preferences/shared_preferences.dart';

var store1;
var interested;

Future<dynamic> getFunction() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  store1 = sharedPreferences.getString("token");
  print("user id-----------------------------------------------------------------------" +"$store1");
 
 return store1;
 
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  // print("object");
  // store = prefs.getString("bearer");
  // print("shared preference on store.dart----------------------" + "$store");
  // return store;
}