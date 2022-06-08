import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/model/ProfileModel.dart';
import 'package:swiftasset/sharedpreference/store.dart';

class PinPage extends StatefulWidget {
  @override
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String token;
  bool isLoading = false;
  ProgressDialog pr;
  TextEditingController pin = TextEditingController();
  TextEditingController cofirmationPin = TextEditingController();
  TextEditingController oldPin = TextEditingController();
  APIService service = APIService();
  @override
  void initState() {
    super.initState();
  }

  Future<void> resetPinOldUser() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "pin": pin.toString(),
      "pin_confirmation": cofirmationPin.toString(),
      "old_pin": oldPin.toString(),
      //"userId": widget.userId,
    });
    String url = "http://dev.swiftassets.net/public/api/post_pin";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var jsonResponse;
    var response = await http.post(url, body: body, headers: {
      //HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $store1"
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      print("response body ${jsonResponse["token"]}");
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "ResetPin Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
       
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => BottomNavigationBarPage()),
            (Route<dynamic> route) => false);
      } else {
        print("respopnse body---------$body");
        print("Error");
        setState(() {
          pr.hide();
        });
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        setState(() {
          pr.hide();
        });
      }
    }
  }

  Future<void> resetPinNewUser() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "pin": pin.toString(),
      "pin_confirmation": cofirmationPin.toString(),
      //"userId": widget.userId,
    });
    String url = "http://dev.swiftassets.net/public/api/post_pin";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var jsonResponse;
    var response = await http.post(url, body: body, headers: {
      //HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $store1"
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      print("response body ${jsonResponse["token"]}");
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "ResetPin Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
       
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => BottomNavigationBarPage()),
            (Route<dynamic> route) => false);
      } else {
        print("respopnse body---------$body");
        print("Error");
        setState(() {
          pr.hide();
        });
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        setState(() {
          pr.hide();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(170, 131, 108, 1),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color.fromRGBO(105, 111, 119, 1),
                  Color.fromRGBO(170, 131, 108, 1)
                ])),
            child: ListView(children: <Widget>[
              Column(children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  title: Text(
                    "Pin",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 50,
                  child: FutureBuilder(
                      future: service.getProfile(),
                      builder: (BuildContext context,
                          AsyncSnapshot<ProfileModel> snapshot) {
                        if (snapshot.hasData) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                top: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  height: MediaQuery.of(context).size.height,
                                  width: 360,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 0,
                                left: 0,
                                child: snapshot.data.data.isPinSet == true
                                    ? Center(
                                  child: new Container(
                                    child: new Card(
                                      color: Colors.white,
                                      elevation: 6.0,
                                      margin: EdgeInsets.only(right: 10.0, left: 10.0),
                                      child: new Wrap(
                                        children: <Widget>[
                                          Center(
                                            child: Form(
                                              key: _formKey,
                                              child: new Container(
                                                margin: EdgeInsets.only(top: 20.0),
                                                child: new Text(
                                                  'Pin',
                                                  style: TextStyle(
                                                      fontSize: 25.0, color: Colors.orange),
                                                ),
                                              ),
                                            ),
                                          ),
                                          new ListTile(
                                            title: new TextFormField(
                                              controller: pin,
                                              decoration: new InputDecoration(
                                                hintText: 'Pin',
                                                labelText: 'pin',
                                              ),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                          new ListTile(
                                            title: new TextFormField(
                                              controller: cofirmationPin,
                                              decoration: new InputDecoration(
                                                hintText: 'Confirm Pin',
                                                labelText: 'Confirm Pin',
                                              ),
                                              keyboardType: TextInputType.text,

                                            ),
                                          ),
                                          new ListTile(

                                            title: new TextFormField(
                                              controller: oldPin,
                                              decoration: new InputDecoration(
                                                hintText: 'Old Pin',
                                                labelText: 'Old Pin',
                                              ),
                                              keyboardType: TextInputType.text,

                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                                            child: Center(
                                              child: new RaisedButton(
                                                onPressed: () {
                                                  final loginForm = _formKey.currentState;

                                                  if (loginForm.validate()) {
                                                    loginForm.save();
                                                    resetPinOldUser();
                                                  } else {
                                                    print("rrrrrrr");
                                                  }
                                                },
                                                color: Colors.orange,
                                                shape: new RoundedRectangleBorder(
                                                    borderRadius:
                                                    new BorderRadius.circular(30.0)),
                                                child: new Text('Update',
                                                    style: new TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                    : Center(
                                  child: new Container(
                                    child: new Card(
                                      color: Colors.white,
                                      elevation: 6.0,
                                      margin: EdgeInsets.only(right: 10.0, left: 10.0),
                                      child: new Wrap(
                                        children: <Widget>[
                                          Center(
                                            child: Form(
                                              key: _formKey,
                                              child: new Container(
                                                margin: EdgeInsets.only(top: 20.0),
                                                child: new Text(
                                                  'Pin',
                                                  style: TextStyle(
                                                      fontSize: 25.0, color: Colors.orange),
                                                ),
                                              ),
                                            ),
                                          ),
                                          new ListTile(

                                            title: new TextFormField(
                                              controller: pin,
                                              decoration: new InputDecoration(
                                                hintText: 'Pin',
                                                labelText: 'pin',
                                              ),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                          new ListTile(
                                            title: new TextFormField(
                                              controller: cofirmationPin,
                                              decoration: new InputDecoration(
                                                hintText: 'Confirm Pin',
                                                labelText: 'Confirm Pin',
                                              ),
                                              keyboardType: TextInputType.text,

                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                                            child: Center(
                                              child: new RaisedButton(
                                                onPressed: () {
                                                  final loginForm = _formKey.currentState;

                                                  if (loginForm.validate()) {
                                                    loginForm.save();
                                                    resetPinNewUser();
                                                  } else {
                                                    print("rrrrrrr");
                                                  }
                                                  print('Login Pressed');
                                                },
                                                color: Colors.orange,
                                                shape: new RoundedRectangleBorder(
                                                    borderRadius:
                                                    new BorderRadius.circular(30.0)),
                                                child: new Text('Update',
                                                    style: new TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                )
              ])
            ])));
  }
}
