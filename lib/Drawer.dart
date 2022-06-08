import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/Approved.dart';
import 'package:swiftasset/ApprovedHistory.dart';
import 'package:swiftasset/CommissionVault.dart';
import 'package:swiftasset/Direct.dart';
import 'package:swiftasset/Distribute.dart';
import 'package:swiftasset/Indirect.dart';
import 'package:swiftasset/Kyc.dart';
import 'package:swiftasset/Login.dart';
import 'package:swiftasset/MyPropertyRewards.dart';
import 'package:swiftasset/Package.dart';
import 'package:swiftasset/Password.dart';
import 'package:http/http.dart' as http;
import 'package:swiftasset/Payment.dart';
import 'package:swiftasset/PayoutHistory.dart';
import 'package:swiftasset/Pin.dart';
import 'package:swiftasset/Profile.dart';
import 'package:swiftasset/PropertyVault.dart';
import 'package:swiftasset/Rank.dart';
import 'package:swiftasset/RequestWithdraw.dart';
import 'package:swiftasset/Resource.dart';
import 'package:swiftasset/dashboardScreen.dart';
import 'package:swiftasset/sharedpreference/store.dart';

class InkWellDrawer extends StatefulWidget {
  @override
  _InkWellDrawerState createState() => _InkWellDrawerState();
}

class _InkWellDrawerState extends State<InkWellDrawer> {
  bool isDataLoaded = false;
   ProgressDialog pr;
    bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

 


  @override
  Widget build(BuildContext ctxt) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color.fromRGBO(105, 111, 119,1),Color.fromRGBO(170, 131, 108,1),])),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: new DecorationImage(
                            image:
                                new AssetImage('assets/images/admin-logo.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Text(
                      'Swift Assets',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    )
                  ],
                ),
              )),
          CustomListTile(
              Icons.home,
              'Home',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => DashboardScrren()))
                  }),
          ExpansionTile(
              title: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(Icons.settings),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Package",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                InkWell(
                  onTap: () {
                     Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => PackagePage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "My Package",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
          ExpansionTile(
              title: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(Icons.settings),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Profile",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => KycPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "KYC",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                 InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => PaymentPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Bank Details",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                 InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => ProfilePage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Personal Information",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
          ExpansionTile(
              title: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(Icons.settings),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "My Business",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => RankPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,bottom: 25),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "My Rank",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    // Navigator.push(
                    //     ctxt,
                    //     new MaterialPageRoute(
                    //         builder: (ctxt) => ProfileVisibiltyPage()));
                  },
                  child:
                   ExpansionTile(
                    title:  Padding(
                    padding: const EdgeInsets.only(left: 10,),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "My Team",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                   children: <Widget>[
                InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => PackagePage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only( bottom: 15),
                    child: Container(
                      width: 180,
                      child: Text(
                        "Network Geneology",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ]
                   ),
                ),
               InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    // Navigator.push(
                    //     ctxt,
                    //     new MaterialPageRoute(
                    //         builder: (ctxt) => ProfileVisibiltyPage()));
                  },
                  child:
                   ExpansionTile(
                    title:  Padding(
                    padding: const EdgeInsets.only(left: 10,),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Members",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                    children: <Widget>[
                InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => DistributePage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only( bottom: 15),
                    child: Container(
                      width: 180,
                      child: Text(
                        "Distributed Search",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => DirectPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only( bottom: 15),
                    child: Container(
                      width: 180,
                      child: Text(
                        "Direct Downline",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => IndirectPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only( bottom: 15),
                    child: Container(
                      width: 180,
                      child: Text(
                        "Indirect Downline",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ]
                   ),
                ),
                  InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    // Navigator.push(
                    //     ctxt,
                    //     new MaterialPageRoute(
                    //         builder: (ctxt) => ProfileVisibiltyPage()));
                  },
                  child:
                   ExpansionTile(
                    title:  Padding(
                    padding: const EdgeInsets.only(left: 10,),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "My Account",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                    children: <Widget>[
                InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => CommissionVaultPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only( bottom: 15),
                    child: Container(
                      width: 180,
                      child: Text(
                        "Commission Vault",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => PropertyVaultPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only( bottom: 15),
                    child: Container(
                      width: 180,
                      child: Text(
                        "Property Vault",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ]
                   ),
                ),
              ]),
          ExpansionTile(
              title: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(Icons.settings),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "My Property Rewards",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => MyPropertyReward()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "My Property Reward",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
          ExpansionTile(
              title: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(Icons.settings),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Payment",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => ApprovedPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Approved Payout",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => ApprovedHistoryPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Approved History",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                    // Navigator.pop(ctxt);
                   Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => RequestWithdrawPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Request Withdraw",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                     Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => RequestWithdrawPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "My Package Transaction History",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  InkWell(
                  onTap: () {
                    Navigator.pop(ctxt);
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) =>  PayoutHistory()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Payout History",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
          CustomListTile(
              Icons.refresh,
              'Resource',
              () => {
                    // Navigator.pop(ctxt),
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => ResourcePage()))
                  }),
          ExpansionTile(
              title: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(Icons.settings),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Settings",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              children: <Widget>[
               
               
               
               
                InkWell(
                  onTap: () {
                    //  Navigator.pop(ctxt),
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => PasswordPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.lock_open, color: Colors.grey, size: 18),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Change Password",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  
                    //  Navigator.pop(ctxt);
                    Navigator.push(ctxt,
                        new MaterialPageRoute(builder: (ctxt) => PinPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.delete_outline,
                            color: Colors.grey, size: 18),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Transaction History",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            //  child: Divider(color: Colors.grey,height: 2,thickness: 1,)
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: CustomListTile(
                Icons.lock,
                'Logout',
                () => {
                      // Navigator.pop(ctxt),
                      showAlertDialog(ctxt)
                    }),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        height: 60,
        // decoration: BoxDecoration(
        //     border: Border(bottom: BorderSide(color: Colors.grey))),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(icon, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                        ),
                        Text(
                          text,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }
}
 
 

showAlertDialog(BuildContext ctxt) {
  Future<void> onLogoutClicked() async {  
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
        Fluttertoast.showToast(
            msg: "LogOut Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
                Navigator.of(ctxt).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()),
                (Route<dynamic> route) => false);
      } else {
                print("Error");
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);

      }
    }}
    
    // NetworkUtil().bearerToken();
   
  

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
    context: ctxt,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
