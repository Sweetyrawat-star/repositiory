import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/Profile.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/model/DashbordModel.dart';
import 'package:swiftasset/webview.dart';

class MyPropertyReward extends StatefulWidget {
  @override
  _MyPropertyRewardState createState() => _MyPropertyRewardState();
}

class _MyPropertyRewardState extends State<MyPropertyReward> {
  String token;
  String packagrTime, packageName, packageImage, packageDate, packageAmount;
  @override
  void initState() {
    super.initState();
    APIService.getRank();
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
           //1  physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Column(
                children: <Widget>[
                  AppBar(
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text(
                      "My Property Rewards",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder<DashBoardModel>(
                        future: APIService.getDashBoard(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            double data = double.parse(
                                    (snapshot.data.data.propertyRewardProgress)
                                        .toStringAsFixed(1)) /
                                100;
                            print(data);
                            return Stack(
                              fit: StackFit.expand,
                              children: [
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
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child:  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 190,
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          elevation: 8,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Property Rewards Progress",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                CircularPercentIndicator(
                                                  radius: 80.0,
                                                  lineWidth: 7.0,
                                                  animation: true,
                                                  percent: data,
                                                  center: snapshot.data.data.propertyRewardProgress
                                                      .toString() ==
                                                      null
                                                      ? Text("")
                                                      : Text(
                                                    snapshot.data.data.propertyRewardProgress
                                                        .toString(),
                                                    style: new TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets.only(left: 10.0, top: 20),
                                                    child: snapshot.data.data.packageAmount == null
                                                        ? Text("")
                                                        : Text(
                                                      snapshot.data.data.packageAmount,
                                                      style: new TextStyle(fontSize: 15.0),
                                                    ),
                                                  ),
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  progressColor: Colors.yellow,
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Positioned(
                                  top: 210,
                                  left: 10,
                                  right: 10,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 190,
                                        width: MediaQuery.of(context).size.width,
                                        child: Card(
                                            elevation: 8,
                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "Property Value in 3 Years",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                    color: Colors.black,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: snapshot.data.data.propertyValueIn3Year
                                                        .toString() ==
                                                        null
                                                        ? Text("")
                                                        : Row(
                                                      children: [
                                                        Text(snapshot.data.data.propertyValueIn3Year
                                                            .toString()),
                                                        Text("  Max"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Alternate Cash Reward",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                    color: Colors.black,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: snapshot.data.data.alternateCashReward
                                                        .toString() ==
                                                        null
                                                        ? Text("")
                                                        : Row(
                                                      children: [
                                                        Text(snapshot.data.data.alternateCashReward
                                                            .toString()),
                                                        Text(" Max"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 150,
                                        width: MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: Card(
                                          elevation: 8,
                                          child: Container(
                                              height: 110,
                                              width: MediaQuery.of(context).size.width,
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0, top: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      buildButton(
                                                          text: "Dashboard",
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        BottomNavigationBarPage()));
                                                          }),
                                                      buildButton(
                                                          text: "Profile",
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        ProfilePage()));
                                                          }),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      buildButton(
                                                          text: "Network",
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        WebsitePage()));
                                                          }),
                                                      buildButton(
                                                          text: "LogOut",
                                                          onTap: () {
                                                            setState(() {
                                                              APIService.onLogoutClicked(context);
                                                            });
                                                          }),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                    ],
                                  ),
                                )
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
                  //CustomCard.buildButton(context: context)
                ],
              ),
            ],
          )),
    );
  }

  buildButton({String text, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          color: Color(0xffFFDBA9),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: new Text(text,
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
