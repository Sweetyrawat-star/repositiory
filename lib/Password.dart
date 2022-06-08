import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/sharedpreference/store.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  bool isLoading = false;
  bool showPassword=false;
  bool _showPassword=false;
  String password,confirmPassword;
  ProgressDialog pr;

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController reconfirmPassword = TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();


  @override
  void initState() {
    super.initState();
    showPassword = true;
    _showPassword = true;
  }
  Future<void> resetPassword() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "password": newPassword.toString(),
      "password_confirmation": reconfirmPassword.toString(),
      //"userId": widget.userId,
    });
    String url = "http://dev.swiftassets.net/public/api/post_password";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var jsonResponse;
    var response = await http.post(url, body: body,headers: {
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
            msg: "ResetPassword Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()));
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
    }}

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        backgroundColor: Color.fromRGBO(170, 131, 108,1),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Color.fromRGBO(105, 111, 119,1),Color.fromRGBO(170, 131, 108,1)])),
            child: ListView(
           
                children: <Widget>[
               
                  Column(
                      children: <Widget>[
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          centerTitle: true,
                          leading: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                              child: Icon(Icons.arrow_back)),
                          title: Text(
                            "Password",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),

                        Container(
                            height: MediaQuery.of(context).size.height-50,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  top: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight:Radius.circular(10.0), ),
                                    ),
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 0,
                                  left: 0,
                                  child:Center(
                                                child: new Container(
                                                  child: new Card(
                                                    color: Colors.white,
                                                    elevation: 6.0,
                                                    margin: EdgeInsets.only(right: 10.0, left: 10.0),
                                                    child: new Wrap(
                                                      children: <Widget>[
                                                        Center(
                                                          child: new Container(
                                                            margin: EdgeInsets.only(top: 20.0),
                                                            child: new Text(
                                                              'Password',
                                                              style: TextStyle(
                                                                  fontSize: 25.0, color:  Colors.orange),
                                                            ),
                                                          ),
                                                        ),
                                                       
                                                  new ListTile(
                                                          leading: const Icon(Icons.lock),
                                                          title: new TextFormField(
                                                            controller: newPassword,
                                                            onSaved: (val) => password = val,
                                                            validator: (val) {
                                                              return val.length < 1 ? "Required" : null;
                                                            },
                                                            keyboardType: TextInputType.text,

                                                            maxLengthEnforced: true,
                                                            obscureText:
                                                            _showPassword,
                                                            decoration: new InputDecoration(

                                                              hintText: 'Password',
                                                              labelText: 'Password',
                                                            ),
                                                          ),
                                                        ),
                                                         new ListTile(
                                                          leading: const Icon(Icons.lock),
                                                          title: new TextFormField(
                                                            keyboardType: TextInputType.text,
                                                            onSaved: (val) => confirmPassword = val,

                                                            maxLengthEnforced: true,
                                                           
                                                            validator: (val) {
                                                              return val.length < 1 ? "Required" : null;
                                                            },
                                                            obscureText: showPassword,
                                                            controller: reconfirmPassword,
                                                            decoration: new InputDecoration(

                                                              hintText: 'Confirm Password',
                                                              labelText: 'Confirm Password',
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                                                          child: Center(
                                                            child:  new RaisedButton(
                                                onPressed: () {
                                                setState(() {
                                                  final loginForm = _key.currentState;

                                                  if (loginForm.validate()) {
                                                    loginForm.save();
                                                    resetPassword();
                                                  } else {
                                                    print("rrrrrrr");
                                                  }
                                                });
                                                },
                                                color: Colors.orange,
                                                shape: new RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius.circular(30.0)),
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
                              ],)

                        )])])));

  }
}