import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/Alert/LogoutAlertBox.dart';
import 'package:swiftasset/Login.dart';
import 'package:swiftasset/Profile.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/dashboardScreen.dart';
import 'package:swiftasset/sharedpreference/store.dart';
import 'package:http/http.dart' as http;

class BottomNavigationBarPage extends StatefulWidget {



  @override
  _BottomNavigationBarPageState createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
   int _selectedIndex = 0;
     TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
 final List<Widget> _widgetOptions =[
   DashboardScrren(),
   ProfilePage(),
   AlertBoxPage(),

   


  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
   Future<void> onLogoutClicked(BuildContext context) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     store1 = sharedPreferences.getString("token");
     print("token" + "$store1");
     String url = "http://dev.swiftassets.net/public/api/logout";

     var jsonResponse;
     var response = await http.post(url, headers: {

     });
     if (response.statusCode == 200) {
       jsonResponse = json.decode(response.body);
       print("response statusCode ${response.statusCode}");
       print("body$jsonResponse");
       if (jsonResponse != null) {
         var token2 = sharedPreferences.getString("token");
         print(token2);
         sharedPreferences.clear();
         Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute(
                 builder: (BuildContext context) => LoginPage()),
                 (Route<dynamic> route) => false);
       } else {
         print("Error");
       }
     }}


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: 'Logout',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
    );
  }
}

showAlertDialog(BuildContext ctxt) {
  Future<void> onLogoutClicked() async {
    Navigator.pushReplacement(
        ctxt,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  Widget cancelButton = FlatButton(
    child: Text(
      "Cancel",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    onPressed: () {
      Navigator.pop(ctxt);
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "Logout",
      style: TextStyle(color: Colors.black),
    ),
    onPressed: () {
      onLogoutClicked();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Log Out App!"),
    content: Text(
      "Do you want to Log Out from the app?",
      style: TextStyle(color: Colors.grey),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: ctxt,
    builder: (BuildContext context) {
      return alert;
    },
  );
}