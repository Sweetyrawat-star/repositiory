import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _key = new GlobalKey();

 
  String firstname, lastname, email, phone, gender, password, sponser, username;
  String _selectedLocation;
  String store;

  List<String>dropdown=["a","b","c"];
  bool isDataLoaded = false;
 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       //resizeToAvoidBottomPadding: true,
        body: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Color.fromRGBO(105, 111, 119,1),Color.fromRGBO(170, 131, 108,1)])),
            child: SingleChildScrollView(
                child: new Form(
              key: _key,
              child: Container(
                padding: EdgeInsets.only(top: 50),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("Register",
                                  style: TextStyle(
                                      fontFamily: "CerebriSans-Bold",
                                      color: Colors.black,
                                      fontSize: 25,
                                      letterSpacing: .6,
                                      fontWeight: FontWeight.bold)),
                                       Text("Sign in >",
                                  style: TextStyle(
                                      fontFamily: "CerebriSans-Bold",
                                      color: Colors.orange,
                                      fontSize: 18,
                                      letterSpacing: .6,
                                      )),
                            ],
                          ),
                        ),
                                  SizedBox(height: 10),
                                 Text("If you're already a member sign in here?",
                            style: TextStyle(
                                
                                color: Colors.black,
                                fontSize: 16,
                                letterSpacing: .6,
                               )),
                               SizedBox(height: 10),
                               Divider(height: 1,color: Colors.black,),
                        SizedBox(height: 20),
                        Container(
                                padding: EdgeInsets.only(left: 10, right: 20),
                                child: DropdownButton(
                                  hint: Text(
                                    'Select Individual?',
                                    style: TextStyle(color: Colors.black),
                                  ), // Not necessary for Option 1
                                  value: _selectedLocation,
                                  isExpanded: true,
                                  iconSize: 30,
                                  underline: Container(
                                    height: 1.0,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.transparent,
                                                width: 0.0))),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedLocation = newValue;
                                    });
                                  },
                                  items: dropdown.map((item) {
                                        return DropdownMenuItem(
                                          child: new Text(item),
                                          value: item
                                        );
                                      }).toList() ??
                                      [],
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            
                        SizedBox(height: 20),
                        Container(
                                padding: EdgeInsets.only(left: 10, right: 20),
                                child: DropdownButton(
                                  hint: Text(
                                    'Select Title.',
                                    style: TextStyle(color: Colors.black),
                                  ), // Not necessary for Option 1
                                  value: _selectedLocation,
                                  isExpanded: true,
                                  iconSize: 30,
                                  underline: Container(
                                    height: 1.0,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.transparent,
                                                width: 0.0))),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedLocation = newValue;
                                    });
                                  },
                                  items: dropdown.map((item) {
                                        return DropdownMenuItem(
                                          child: new Text(item),
                                          value: item
                                        );
                                      }).toList() ??
                                      [],
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            
                        SizedBox(height: 20),
                       
                        ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 70),
                            child: _firstNameField()),
                        ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 70),
                            child: _lastNameField()),
                        ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 70),
                            child: _emailField()),
                             ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 70),
                            child: _userNameField()),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 70),
                          child: _phonenumberField(),
                        ),
                         Container(
                                padding: EdgeInsets.only(left: 10, right: 20),
                                child: DropdownButton(
                                  hint: Text(
                                    'Select State',
                                    style: TextStyle(color: Colors.black),
                                  ), // Not necessary for Option 1
                                  value: _selectedLocation,
                                  isExpanded: true,
                                  iconSize: 30,
                                  underline: Container(
                                    height: 1.0,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.transparent,
                                                width: 0.0))),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedLocation = newValue;
                                    });
                                  },
                                  items: dropdown.map((item) {
                                        return DropdownMenuItem(
                                          child: new Text(item),
                                          value: item
                                        );
                                      }).toList() ??
                                      [],
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            
                        SizedBox(height: 20),
                        Container(
                                padding: EdgeInsets.only(left: 10, right: 20),
                                child: DropdownButton(
                                  hint: Text(
                                    'Select Country',
                                    style: TextStyle(color: Colors.black),
                                  ), // Not necessary for Option 1
                                  value: _selectedLocation,
                                  isExpanded: true,
                                  iconSize: 30,
                                  underline: Container(
                                    height: 1.0,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.transparent,
                                                width: 0.0))),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedLocation = newValue;
                                    });
                                  },
                                  items: dropdown.map((item) {
                                        return DropdownMenuItem(
                                          child: new Text(item),
                                          value: item
                                        );
                                      }).toList() ??
                                      [],
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            
                        SizedBox(height: 20),
                      
                        ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 70),
                            child: _passwordField()),
                             ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 70),
                            child: _confirmPasswordField()),
                              ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 70),
                            child: _sponserField()),
                        Container(
                          // color: Colors.orange,
                          margin: EdgeInsets.only(top: 20),
                          width: 300,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.orange,
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              // final loginForm = _key.currentState;

                              // if (loginForm.validate()) {
                              //   loginForm.save();
                              //   register();
                              //   // getFunction();

                              //   // Navigator.pop(context);
                              // } else {
                              //   print("rrrrrrr");
                              // }
                            },
                            child: Text(
                              'Create an Account',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: InkWell(
                            child: Text("Back to sign in"),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ))));
  }
   TextFormField _userNameField() {
    return TextFormField(
      onSaved: (val) => username = val,
      validator: (val) {
        return val.length < 1 ? "Required" : null;
      },
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Username",
          hintText: "Username",
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: ' ',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
          )),
    );
  }

  TextFormField _firstNameField() {
    return TextFormField(
      onSaved: (val) => firstname = val,
      validator: (val) {
        return val.length < 1 ? "Required" : null;
      },
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "First Name",
          hintText: "First Name",
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: ' ',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
          )),
    );
  }

  TextFormField _lastNameField() {
    return TextFormField(
      onSaved: (val) => lastname = val,
      validator: (val) {
        return val.length < 1 ? "Required" : null;
      },
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Last Name",
          hintText: "Last Name",
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: ' ',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
          )),
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      onSaved: (val) => email = val,
      validator: (val) {
        return val.length < 1 ? "Required" : null;
      },
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Email Address",
          hintText: "Email Address",
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: ' ',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
          )),
    );
  }

  TextFormField _phonenumberField() {
    return TextFormField(
      onSaved: (val) => phone = val,
      validator: (val) {
        return val.length < 1 ? "Required" : null;
      },
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Phone Number",
          hintText: "Phone Number",
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: ' ',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
          )),
    );
  }

  TextFormField _sponserField() {
    return TextFormField(
      onSaved: (val) => sponser = val,
      validator: (val) {
        return val.length < 1 ? "Required" : null;
      },
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Sponsor ",
          hintText: "Sponsor",
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: ' ',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
          )),
    );
  }

  TextFormField _passwordField() {
    return TextFormField(
      onSaved: (val) => password = val,
      validator: (val) {
        return val.length < 1 ? "Required" : null;
      },
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "Password",
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: ' ',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
          )),
    );
  }

   TextFormField _confirmPasswordField() {
    return TextFormField(
      onSaved: (val) => password = val,
      validator: (val) {
        return val.length < 1 ? "Required" : null;
      },
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Confirm Password",
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          counterText: ' ',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid),
          )),
    );
  }
}