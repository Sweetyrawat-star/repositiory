import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/model/ApprovedModel.dart';
import 'package:swiftasset/sharedpreference/store.dart';

class ApprovedHistoryPage extends StatefulWidget {
  @override
  _ApprovedHistoryPageState createState() => _ApprovedHistoryPageState();
}

class _ApprovedHistoryPageState extends State<ApprovedHistoryPage> {
  final controller = ScrollController();
  APIService service = APIService();
  double offset = 0;

  Future<List<Result>> _func;
  @override
  void initState() {
    super.initState();
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
              // new Image.asset(
              //   'assets/images/b-c2.png',
              //   fit: BoxFit.cover,
              // ),
              Column(children: <Widget>[
                AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  // leading: Icon(Icons.arrow_back),
                  title: Text(
                    "List",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder<List<Result>>(
                        future: _func,
                        builder: (context, snapshot) {
                          List<Result> data = snapshot.data;
                          if (snapshot.hasData) {
                            return Stack(fit: StackFit.expand, children: [
                              // buildMyPackage(),
                              Positioned(
                                top: 50,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  height: MediaQuery.of(context).size.height,
                                  //color: Colors.white,
                                   width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 210,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                            child: ListView(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.0),
                                                          child: Center(
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: DataTable(
                                                                sortColumnIndex:
                                                                    0,
                                                                sortAscending:
                                                                    true,
                                                                columns: [
                                                                  DataColumn(
                                                                    label: Text(
                                                                      'Amount',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                      'Description',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
                                                                      'Status',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  DataColumn(
                                                                    label: Text(
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
                                                                                    )
                                                                                  : Text(
                                                                                      country.amount,
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      softWrap: false,
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
                                                                                        maxLines: 2,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        softWrap: false,
                                                                                      ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            Center(
                                                                                child: country.description.isEmpty
                                                                                    ? Text(
                                                                                        "",
                                                                                      )
                                                                                    : Text(
                                                                                        country.description,
                                                                                        maxLines: 2,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        softWrap: false,
                                                                                      )),
                                                                          ),
                                                                          DataCell(
                                                                            Center(
                                                                              child: country.paymentMethod.isEmpty
                                                                                  ? Text(
                                                                                      "",
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    )
                                                                                  : Text(
                                                                                      country.paymentMethod,
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      softWrap: false,
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
                                                : Container(
                                                    child:
                                                        Text("No Data Found"),
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 200.0),
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
                                                    color: Color(0xffFF4A00),
                                                    child: Center(
                                                        child: Text(
                                                      "1",
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                //CustomCard.buildButton(context: context)
                              )
                            ]);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }))
              ])
            ])));
  }
}
