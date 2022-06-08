  import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/Login.dart';
import 'package:flutter/material.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/sharedpreference/store.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
 bool showImageWidget = false;
 String messageTitle = "Empty";
 String notificationAlert = "alert";
 FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    getFunction();
      APIService.getDashBoard();
    APIService.getBanner();
    @override
    void initState() {
      super.initState();

      _firebaseMessaging.configure(
        onMessage: (message) async{
          setState(() {
            messageTitle = message["notification"]["title"];
            notificationAlert = "New Notification Alert";
          });

        },
        onResume: (message) async{
          setState(() {
            messageTitle = message["data"]["title"];
            notificationAlert = "Application opened from Notification";
          });

        },
      );
    }

  }

  Future<dynamic> getFunction() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token-----------------------------------------------------------------------" +"$store1");
    navigatorPage();

    return store1;
  }

  Future<void> navigatorPage() async {

    if (store1 == null) {
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(),
          )));
    } else {

      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => BottomNavigationBarPage(),
          )));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,   
      body: Stack(   
        children: <Widget>[
          Container(
               height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset(
                "assets/images/Logo.png",
                fit: BoxFit.fill,
              ),
            ),
          
          ),
        
        ],
      ),
    );
  }
}
