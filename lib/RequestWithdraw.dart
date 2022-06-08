import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/model/withdawlistModel.dart';
import 'package:swiftasset/sharedpreference/store.dart';

class RequestWithdrawPage extends StatefulWidget {
  @override
  _RequestWithdrawPageState createState() => _RequestWithdrawPageState();
}

class _RequestWithdrawPageState extends State<RequestWithdrawPage> {
  GlobalKey<FormState> key = new GlobalKey();
  String amount, via, vault, transaction, passwprd;
  String selectVia, selectVault;
  ProgressDialog pr;
  final controller = ScrollController();
  APIService service = APIService();
  double offset = 0;

  Future<List<Result>> _func;
  @override
  void initState() {
    super.initState();
    APIService.getCommissionVault();
    _func = fetchSummary();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  Future<List<Result>> fetchSummary() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    final response = await http
        .get('http://dev.swiftassets.net/public/api/withdraw/list', headers: {
      "Content-Type": "application/json",
      'Authorization': '$header',
    });

    if (response.statusCode == 200) {
      var parsed = json.decode(response.body);
      List jsonResponse = parsed["data"]["results"] as List;
      return jsonResponse.map((job) => new Result.fromJson(job)).toList();
    } else {
      print('Error, Could not load Data.');
      throw Exception('Failed to load Data');
    }
  }

  withDrawListUpload() async {
    setState(() {
      pr.show();
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    //create multipart request for POST or PATCH method
    final String url = "http://dev.swiftassets.net/public/api/add_withdraw";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // var request = http.MultipartRequest
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['payment_method'] = selectVia.toString();
    request.fields['amount'] = amount.toString();
    request.fields['vault'] = selectVault.toString();
    request.fields['transaction_password'] = transaction.toString();

    print(request);
    var response = await request.send();
    print(response);
    setState(() {
      pr.hide();
    });
    Fluttertoast.showToast(
        msg: "Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[200],
        textColor: Colors.black,
        fontSize: 16.0);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RequestWithdrawPage()));
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
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
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: Text(
                    "List",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height,
                     width: MediaQuery.of(context).size.width,
                    child: FutureBuilder<List<Result>>(
                      future: _func,
                      builder: (ctx, snapshot) {
                        if (snapshot.hasData) {
                          List<Result> data = snapshot.data;
                          return Stack(fit: StackFit.expand, children: [
                            Positioned(
                              top: 60,
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
                              top: 0,
                              right: 10,
                              left: 10,
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 8,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 10.0, bottom: 15.0),
                                    child: Center(
                                      child: new RaisedButton(
                                        onPressed: () {
                                          productDetails(context);
                                          print('Login Pressed');
                                        },
                                        color: Colors.orange,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                        child: new Text('Request Withdraw',
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 110,
                                left: 0,
                                right: 0,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 210,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                            elevation: 8,
                                            child: ListView(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    "Withdraw Request",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                data.isNotEmpty
                                                    ? SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          10.0),
                                                              child: Center(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child:
                                                                      DataTable(
                                                                    sortColumnIndex:
                                                                        0,
                                                                    sortAscending:
                                                                        true,
                                                                    columns: [
                                                                      DataColumn(
                                                                        label:
                                                                            Text(
                                                                          'Amount',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataColumn(
                                                                        label:
                                                                            Text(
                                                                          'Description',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataColumn(
                                                                        label:
                                                                            Text(
                                                                          'Status',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataColumn(
                                                                        label:
                                                                            Text(
                                                                          'Payment Method',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    rows: data
                                                                        .map(
                                                                          (country) =>
                                                                              DataRow(
                                                                            cells: [
                                                                              DataCell(
                                                                                Container(
                                                                                  width: 100,
                                                                                  child: country.amount.isEmpty
                                                                                      ? Text(
                                                                                          (""),
                                                                                          softWrap: true,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        )
                                                                                      : Text(
                                                                                          country.amount,
                                                                                          softWrap: true,
                                                                                          maxLines: 2,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                ),
                                                                              ),
                                                                              DataCell(
                                                                                Container(
                                                                                  width: 60.0,
                                                                                  child: Center(
                                                                                    child: country.description.isEmpty
                                                                                        ? Text(
                                                                                            "",
                                                                                          )
                                                                                        : Text(
                                                                                            country.amount,
                                                                                            softWrap: true,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              DataCell(
                                                                                Center(
                                                                                    child: country.approveStatus.isEmpty
                                                                                        ? Text(
                                                                                            "",
                                                                                          )
                                                                                        : Text(
                                                                                            country.approveStatus,
                                                                                            softWrap: true,
                                                                                            maxLines: 2,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          )),
                                                                              ),
                                                                              DataCell(
                                                                                Center(
                                                                                  child: country.paymentMethod.isEmpty
                                                                                      ? Text(
                                                                                          "",
                                                                                        )
                                                                                      : Text(
                                                                                          country.paymentMethod,
                                                                                          softWrap: true,
                                                                                          maxLines: 2,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                        .toList(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            // SizedBox(height: 500),
                                                          ],
                                                        ),
                                                      )
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    "Showing 1 to 3 of 3 entries",
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ))
                          ]);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  productDetails(BuildContext context) {
    // set up the buttons
    Widget submitButton = Container(
      margin: EdgeInsets.symmetric(horizontal: 95),
      child: FlatButton(
          color: Color.fromRGBO(170, 131, 108, 1),
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            final loginForm = key.currentState;
            if (loginForm.validate()) {
              loginForm.save();
              withDrawListUpload();
            } else {
              print("rrrrrrr");
            }
          }),
    );

    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      title: Container(
          padding: EdgeInsets.only(left: 10.0),
          height: 40.0,
          color: Color.fromRGBO(170, 131, 108, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Request Withdraw",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700),
              ),
              IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          )),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Form(
            key: key,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 1.0, right: 1.0, bottom: 5.0),
                    padding: EdgeInsets.only(
                        left: 15.0, top: 2.0, right: 15.0, bottom: 2.0),
                    height: 40.0,
                    // width: 220,
                    child: DropdownButton<String>(
                      value: selectVia,
                      items: <String>['bitcoin', 'bank']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style:
                                  TextStyle(color: Color.fromRGBO(0, 0, 0, 1))),
                        );
                      }).toList(),
                      hint: Text('Select Via'),
                      onChanged: (String value) {
                        setState(() {
                          selectVia = value;
                        });
                      },
                      isExpanded: true,
                      iconEnabledColor: Color.fromRGBO(170, 131, 108, 1),
                      underline: Container(
                        height: 1.0,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.transparent, width: 0.0))),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border(
                            left: BorderSide(
                          width: 5.0,
                          color: Color.fromRGBO(170, 131, 108, 1),
                        )),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2.0,
                              color: Color.fromRGBO(0, 0, 0, 0.2))
                        ])),
                Container(
                    margin: EdgeInsets.only(
                        left: 1.0, top: 5.0, right: 1.0, bottom: 5.0),
                    padding: EdgeInsets.only(
                        left: 15.0, top: 2.0, right: 15.0, bottom: 2.0),
                    height: 40.0,
                    // width: 220,
                    child: DropdownButton<String>(
                      value: selectVault,
                      items: <String>['commission', 'property']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style:
                                  TextStyle(color: Color.fromRGBO(0, 0, 0, 1))),
                        );
                      }).toList(),
                      hint: Text('Select Vault'),
                      onChanged: (String value) {
                        setState(() {
                          selectVault = value;
                        });
                      },
                      isExpanded: true,
                      iconEnabledColor: Color.fromRGBO(170, 131, 108, 1),
                      underline: Container(
                        height: 1.0,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.transparent, width: 0.0))),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border(
                            left: BorderSide(
                          width: 5.0,
                          color: Color.fromRGBO(170, 131, 108, 1),
                        )),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2.0,
                              color: Color.fromRGBO(0, 0, 0, 0.2))
                        ])),
                Container(
                    padding: EdgeInsets.only(top: 5),
                    height: 40.0,
                    width: 180.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (val) => amount = val,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.green,
                          )),
                          labelText: "Amount",
                          labelStyle: TextStyle(color: Colors.grey)),
                    )),
                Container(
                    padding: EdgeInsets.only(top: 5),
                    height: 40.0,
                    width: 180.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (val) => transaction = val,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.green,
                          )),
                          labelText: "Transaction Password",
                          labelStyle: TextStyle(color: Colors.grey)),
                    )),
              ],
            ),
          );
        },
      ),
      actions: [
        submitButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(),
          child: alert,
        );
      },
    );
  }
}
