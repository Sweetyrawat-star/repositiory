
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/model/directDistributeModel.dart';
import 'package:swiftasset/sharedpreference/store.dart';
import 'package:http/http.dart' as http;

class DirectPage extends StatefulWidget {
  @override
  _DirectPageState createState() => _DirectPageState();
}

class _DirectPageState extends State<DirectPage> {
  String _brandDropdownValue;
  final controller = ScrollController();
  double offset = 0;

  Future<List<Datum>> _func;

  @override
  void initState() {
    _func = fetchSummary();
    controller.addListener(onScroll);
    super.initState();
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
  Future<List<Datum>> fetchSummary() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    final response = await http.get(
        'http://dev.swiftassets.net/public/api/distribute/direct',
        headers: {
          "Content-Type": "application/json",
          'Authorization': '$header',
        });

    if (response.statusCode == 200) {
      var parsed = json.decode(response.body);
      List jsonResponse = parsed["data"] as List;

      return jsonResponse.map((job) => new Datum.fromJson(job)).toList();
    } else {
      print('Error, Could not load Data.');
      throw Exception('Failed to load Data');
    }
  }

  Future<DirectDistributeModel> getDistribute() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      print("token" + "$store1");
      var header = "Bearer $store1";
      final url = "http://dev.swiftassets.net/public/api/distribute/direct";

      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Authorization': '$header',
      });
      print(response);
      if (response.statusCode == 200) {
        final getProduct = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);

        return DirectDistributeModel.fromJson(getProduct);
      } else {}
    } catch (e) {
      print("catch error");
    }
    return DirectDistributeModel();
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
                //physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
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
                        "Direct",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height - 50,
                        child: FutureBuilder<List<Datum>>(
                            future: _func,
                            builder: (ctx, snapshot) {
                              if (snapshot.hasData) {
                                List<Datum> data = snapshot.data;
                                return Stack(fit: StackFit.expand, children: [
                                 
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
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 370,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Card(
                                                elevation: 8,
                                                child: ListView(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                        "List",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              "Show",
                                                            ),
                                                          ),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          10.0,
                                                                      top: 15.0,
                                                                      right:
                                                                          10.0,
                                                                      bottom:
                                                                          5.0),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          15.0,
                                                                      top: 2.0,
                                                                      right:
                                                                          15.0,
                                                                      bottom:
                                                                          2.0),
                                                              height: 50.0,
                                                              width: 200,
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                value:
                                                                    _brandDropdownValue,
                                                                items: <String>[
                                                                    '10', '25','50','100'
                                                                ].map<
                                                                    DropdownMenuItem<
                                                                        String>>((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value,
                                                                        style: TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                1))),
                                                                  );
                                                                }).toList(),
                                                                hint: Text(
                                                                    'Select'),
                                                                onChanged:
                                                                    (String
                                                                        value) {
                                                                  setState(() {
                                                                    _brandDropdownValue =
                                                                        value;
                                                                  });
                                                                },
                                                                isExpanded:
                                                                    true,
                                                                iconEnabledColor:
                                                                    Color
                                                                        .fromRGBO(
                                                                            170,
                                                                            131,
                                                                            108,
                                                                            1),
                                                                underline:
                                                                    Container(
                                                                  height: 1.0,
                                                                  decoration: const BoxDecoration(
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 0.0))),
                                                                ),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Color.fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                      border: Border(
                                                                          left: BorderSide(
                                                                        width:
                                                                            5.0,
                                                                        color: Color.fromRGBO(
                                                                            170,
                                                                            131,
                                                                            108,
                                                                            1),
                                                                      )),
                                                                      boxShadow: [
                                                                    BoxShadow(
                                                                        blurRadius:
                                                                            2.0,
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.2))
                                                                  ])),
                                                          Container(
                                                            child: Text(
                                                              "Entries",
                                                            ),
                                                          ),
                                                        ],
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
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 10.0),
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
                                                                              'Name',
                                                                              style: TextStyle(
                                                                                fontSize: 18.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataColumn(
                                                                            label:
                                                                                Text(
                                                                              'Username',
                                                                              style: TextStyle(
                                                                                fontSize: 16.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataColumn(
                                                                            label:
                                                                                Text(
                                                                              'Email',
                                                                              style: TextStyle(
                                                                                fontSize: 16.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataColumn(
                                                                            label:
                                                                                Text(
                                                                              'Mobile',
                                                                              style: TextStyle(
                                                                                fontSize: 16.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataColumn(
                                                                            label:
                                                                                Text(
                                                                              'Address',
                                                                              style: TextStyle(
                                                                                fontSize: 16.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataColumn(
                                                                            label:
                                                                                Text(
                                                                              'Doc Verified',
                                                                              style: TextStyle(
                                                                                fontSize: 16.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataColumn(
                                                                            label:
                                                                                Text(
                                                                              'source of signup',
                                                                              style: TextStyle(
                                                                                fontSize: 16.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataColumn(
                                                                            label:
                                                                                Text(
                                                                              'sponser ID',
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
                                                                                      child:  country.name.toString() != null? Text(
                                                                                        country.name.toString(),
                                                                                        softWrap: true,
                                                                                        maxLines: 2,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ): Text(""),
                                                                                    ),
                                                                                  ),
                                                                                  DataCell(
                                                                                    Container(
                                                                                      width: 60.0,
                                                                                      child: Center(
                                                                                        child:  country.username.toString() != null? Text(
                                                                                          country.username.toString(),
                                                                                          softWrap: true,
                                                                                          maxLines: 2,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ): Text(""),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  DataCell(
                                                                                    Center(
                                                                                      child:  country.email.toString() != null? Text(
                                                                                        country.email.toString(),
                                                                                        softWrap: true,
                                                                                        maxLines: 2,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ): Text(""),
                                                                                    ),
                                                                                  ),
                                                                                  DataCell(
                                                                                    Center(
                                                                                      child:  country.mobile.toString()!= null?Text(
                                                                                        country.mobile.toString(),
                                                                                        softWrap: true,
                                                                                        maxLines: 2,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ): Text(""),
                                                                                    ),
                                                                                  ),
                                                                                  DataCell(
                                                                                    Center(
                                                                                      child: country.address.toString()!= null? Text(
                                                                                        country.address.toString(),
                                                                                        softWrap: true,
                                                                                        maxLines: 2,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ): Text(""),
                                                                                    ),
                                                                                  ),
                                                                                  DataCell(
                                                                                    Center(
                                                                                      child: country.isDocVerified.toString()!= null? Text(
                                                                                        country.isDocVerified.toString(),
                                                                                        softWrap: true,
                                                                                        maxLines: 2,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ):Text(""),
                                                                                    ),
                                                                                  ),
                                                                                  DataCell(
                                                                                    Center(
                                                                                      child: country.sourceOfSignup.toString()!= null? Text(
                                                                                        country.sourceOfSignup.toString(),
                                                                                      ): Text(""),
                                                                                    ),
                                                                                  ),
                                                                                  DataCell(
                                                                                    Center(
                                                                                      child:   country.sponserId.toString()!= null? Text(
                                                                                        country.sponserId.toString(),
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
                                                        : Center(
                                                            child: Text(
                                                                "No Data Found"),
                                                          ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Text(
                                                          "Showing 1 to 3 of 3 entries",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
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
                                                              color:
                                                                  Colors.white),
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
                                  )
                                ]);
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }
                            // child:   ],),
                            ))
                  ])
                ])));
  }
}
