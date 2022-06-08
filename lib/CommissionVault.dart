import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/model/commission_vault_model.dart';
import 'package:swiftasset/sharedpreference/store.dart';

class CommissionVaultPage extends StatefulWidget {
  @override
  _CommissionVaultPageState createState() => _CommissionVaultPageState();
}

class _CommissionVaultPageState extends State<CommissionVaultPage> {
  String _brandDropdownValue;
  String token;
  String name, username, avatar, member;

  @override
  void initState() {
    super.initState();
    APIService.getCommissionVault();
    _func = fetchSummary();
    controller.addListener(onScroll);
  }

  final controller = ScrollController();
  double offset = 0;

  Future<List<Result>> _func;

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
    final response = await http.get(
        'http://dev.swiftassets.net/public/api/commission_vault',
        headers: {
          "Content-Type": "application/json",
          'Authorization': '$header',
        });

    if (response.statusCode == 200) {
      var parsed = json.decode(response.body);
      // print(parsed.length);
      List jsonResponse = parsed["data"]["results"] as List;

      return jsonResponse.map((job) => new Result.fromJson(job)).toList();
    } else {
      print('Error, Could not load Data.');
      throw Exception('Failed to load Data');
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
            child: ListView(
               
                children: <Widget>[
                
                  Column(children: <Widget>[
                    AppBar(
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                     
                      title: Text(
                        "Direct",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height,
                        child: FutureBuilder(
                            future: APIService.getCommissionVault(),
                            builder: (BuildContext context,
                                AsyncSnapshot<CommissionVaultModel> snapshot) {
                              if (snapshot.hasData) {
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // buildMyPackage(),
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
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      left: 0,
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height: 100,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Card(
                                                      elevation: 8,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.all(20.0),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Text(
                                                                  "Total Approved",
                                                                  style: TextStyle(fontSize: 18),
                                                                ),
                                                                snapshot.data.data.totalCurrent.toString() ==
                                                                    null
                                                                    ? Container()
                                                                    : Text(
                                                                  snapshot.data.data.totalCurrent
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 15, color: Colors.grey),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          snapshot.data.data.totalCommissionImage
                                                              .toString() ==
                                                              null
                                                              ? Image.asset(
                                                            "assets/images/citizen1.png",
                                                            width: 120,
                                                          )
                                                              : Image.network(
                                                            snapshot.data.data.totalCommissionImage
                                                                .toString(),
                                                            width: 120,
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height: 310,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Card(
                                                      elevation: 8,
                                                      child: ListView(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.all(5),
                                                            child:
                                                            snapshot.data.data.headingTitle.toString() ==
                                                                null
                                                                ? Text(" ")
                                                                : Text(
                                                              snapshot.data.data.headingTitle
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.spaceAround,
                                                              children: [
                                                                Container(
                                                                  child: Text(
                                                                    "Show",
                                                                  ),
                                                                ),
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: 10.0,
                                                                        top: 15.0,
                                                                        right: 10.0,
                                                                        bottom: 5.0),
                                                                    padding: EdgeInsets.only(
                                                                        left: 15.0,
                                                                        top: 2.0,
                                                                        right: 15.0,
                                                                        bottom: 2.0),
                                                                    height: 50.0,
                                                                    width: 200,
                                                                    child: DropdownButton<String>(
                                                                      value: _brandDropdownValue,
                                                                      items: <String>[  '10', '25','50','100']
                                                                          .map<DropdownMenuItem<String>>(
                                                                              (String value) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: value,
                                                                              child: Text(value,
                                                                                  style: TextStyle(
                                                                                      color: Color.fromRGBO(
                                                                                          0, 0, 0, 1))),
                                                                            );
                                                                          }).toList(),
                                                                      hint: Text('Select'),
                                                                      onChanged: (String value) {
                                                                        setState(() {
                                                                          _brandDropdownValue = value;
                                                                        });
                                                                      },
                                                                      isExpanded: true,
                                                                      iconEnabledColor:
                                                                      Color.fromRGBO(170, 131, 108, 1),
                                                                      underline: Container(
                                                                        height: 1.0,
                                                                        decoration: const BoxDecoration(
                                                                            border: Border(
                                                                                bottom: BorderSide(
                                                                                    color: Colors.transparent,
                                                                                    width: 0.0))),
                                                                      ),
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                        Color.fromRGBO(255, 255, 255, 1),
                                                                        border: Border(
                                                                            left: BorderSide(
                                                                              width: 5.0,
                                                                              color: Color.fromRGBO(
                                                                                  170, 131, 108, 1),
                                                                            )),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              blurRadius: 2.0,
                                                                              color: Color.fromRGBO(
                                                                                  0, 0, 0, 0.2))
                                                                        ])),
                                                                Container(
                                                                  child: Text(
                                                                    "Entries",
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          buildDataTable(),
                                                          Container(
                                                            child: Text(
                                                              "Showing 1 to 3 of 3 entries",
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 200.0),
                                            child: Container(
                                              //padding: EdgeInsets.only(left: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Previous",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.all(5),
                                                      width: 20,
                                                      color: Colors.white,
                                                      child: Container(
                                                          height: 20,
                                                          width: 30,
                                                          color:
                                                              Color(0xffFF4A00),
                                                          child: Center(
                                                              child: Text(
                                                            "1",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )))),
                                                  Text(
                                                    "Next",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
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
                            }))
                  ])
                ])));
  }

  buildDataTable() {
    return FutureBuilder<List<Result>>(
      future: _func,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          List<Result> data = snapshot.data;
          // print(data);
          return data.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              sortColumnIndex: 0,
                              sortAscending: true,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'Refer To',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'TransactionType',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Amount',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                              rows: data
                                  .map(
                                    (country) => DataRow(
                                      cells: [
                                        DataCell(
                                          Container(
                                            width: 100,
                                            child: country.referTo.toString()!= null?Text(
                                              country.referTo.toString(),
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ):Text(""),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 60.0,
                                            child: Center(
                                              child:  country.description.toString()!= null?Text(
                                                country.description.toString(),
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ):Text(""),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child:  country.transactionType
                                                .toString()!= null? Text(
                                              country.transactionType
                                                  .toString(),
                                               softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ):Text(""),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child: country.amount.toString()!= null? Text(
                                              country.amount.toString(),
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ):Text(""),
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
              : Container(
                  child: Text("No Data Found"),
                );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
