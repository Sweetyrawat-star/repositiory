import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/Password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _showPassword = false;
  String password;
  String email;
  var data;
  var d;
  ProgressDialog pr;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> signUp() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "username": email.toString(),
      "password": password.toString(),
    });
    String url = "http://dev.swiftassets.net/public/api/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse;
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");

      print("body$jsonResponse");
      var status = jsonResponse["status"];
      var msg = jsonResponse["message"];

      print(status);
      if (jsonResponse != null&& status!=false) {
        setState(() {
          isLoading = false;
        });
        sharedPreferences.setString("token",jsonResponse["token"].toString());
        print("token " +
            "${jsonResponse["token"].toString()}");
               var token = sharedPreferences.getString("token");
        print(token);
         Fluttertoast.showToast(
        msg: msg,
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
    }}

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      backgroundColor: Color.fromRGBO(105, 111, 119, 1),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image.asset(
                    "assets/images/b-c1.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 180),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Login with SwiftAsset ",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Form(
                      key: _key,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                                controller: emailController,
                                onSaved: (val) => email = val,
                                // initialValue: "abc",
                                validator: (val) {
                                  return val.length < 1 ? "Required" : null;
                                },
                                decoration: InputDecoration(
                                    labelText: "Username",
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.orange),
                                    ),
                                    border: UnderlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Colors.black,
                                    ))),
                            TextFormField(
                              onSaved: (val) => password = val,
                              // initialValue: "111111111",
                              validator: (val) {
                                return val.length < 1 ? "Required" : null;
                              },
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              obscureText:
                                  !_showPassword,
                                  
                                    // maxLength: 10, //This will obscure text dynamically
                              decoration: InputDecoration(
                                //counterText: "",
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                hintText: 'Enter your password',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.orange),
                                ),
                                border: UnderlineInputBorder(),
                                prefixIcon:Icon(Icons.lock,color: Colors.black,),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: InkWell(
                        child: Align(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.orange),
                          ),
                          alignment: Alignment.topRight,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctxt) => PasswordPage()));
                        },
                      ),
                    ),
                                     SizedBox(
                      height: 55,
                    ),
                    Center(
                      child: Container(
                        width: 150,
                        child: RaisedButton(
                          onPressed:() {
                            final loginForm = _key.currentState;

                            if (loginForm.validate()) {
                              loginForm.save();
                              signUp();
                            } else {
                              print("rrrrrrr");
                            }
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Container(
                            width: 150,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                gradient: new LinearGradient(
                                  colors: [
                                    Color.fromRGBO(105, 111, 119, 1),
                                    Color.fromRGBO(170, 131, 108, 1)
                                  ],
                                )),
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.0,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 120.0),
                child: Center(
                  child:   Image.asset("assets/images/Logo.png",height: 60,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
