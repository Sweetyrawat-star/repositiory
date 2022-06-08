import 'package:flutter/material.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/Login.dart';
import 'package:swiftasset/api/api_service.dart';

class AlertBoxPage extends StatefulWidget {
  @override
  _AlertBoxPageState createState() => _AlertBoxPageState();
}

class _AlertBoxPageState extends State<AlertBoxPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text("Log Out App!"),
    content: Text(
    "Do you want to Log Out from the app?",
    style: TextStyle(color: Colors.grey),),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "No ",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
               Navigator.of(context).pushReplacement(
                   MaterialPageRoute(builder: (BuildContext context) => BottomNavigationBarPage()));

            },
          ),
          FlatButton(
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              APIService.onLogoutClicked(context);
              // Navigator.of(ctxt).pushReplacement(
              //       MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
            },
          )
        ],
      ),
    );


  }
  showAlertDialog() {
    Future<void> onLogoutClicked() async {
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.clear();

      // NetworkUtil().bearerToken();
      Navigator.pushReplacement(
          context,
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
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Logout",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        onLogoutClicked();
        // Navigator.of(ctxt).pushReplacement(
        //       MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
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
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
}}
