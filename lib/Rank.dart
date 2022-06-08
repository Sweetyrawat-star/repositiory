import 'package:flutter/material.dart';
import 'package:swiftasset/Profile.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/dashboardScreen.dart';
import 'package:swiftasset/model/rank_model.dart';
import 'package:swiftasset/webview.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
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
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Column(
                children: <Widget>[
                  AppBar(
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text(
                      "Rank",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder(
                        future: APIService.getRank(),
                        builder: (BuildContext context,
                            AsyncSnapshot<RankModel> snapshot) {
                          if (snapshot.hasData) {
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
                                      height: 150,
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          child: Row(
                                            children: <Widget>[
                                              snapshot.data.data.rankImage.toString() == null
                                                  ? Image.asset(
                                                "assets/images/citizen1.png",
                                                width: 120,
                                              )
                                                  : Image.network(
                                                snapshot.data.data.rankImage.toString(),
                                                width: 120,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Rank Name: ",
                                                        style: TextStyle(fontSize: 18),
                                                      ),
                                                      snapshot.data.data.nextRank.toString() == null
                                                          ? Container()
                                                          : Text(
                                                        snapshot.data.data.nextRank.toString(),
                                                        style: TextStyle(fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Total Member(s)- ",
                                                        style: TextStyle(fontSize: 15, color: Colors.grey),
                                                      ),
                                                      snapshot.data.data.totalMembers.toString() == null
                                                          ? Container()
                                                          : Text(
                                                        snapshot.data.data.nextRank.toString(),
                                                        style: TextStyle(
                                                            fontSize: 15, color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                                                    child: Center(
                                                      child: new RaisedButton(
                                                        onPressed: () {
                                                          identification(context);
                                                          print('Login Pressed');
                                                        },
                                                        color: Colors.orange,
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius: new BorderRadius.circular(30.0)),
                                                        child: new Text('Next',
                                                            style: new TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.bold)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Positioned(
                                  top: 170,
                                  left: 10,
                                  right: 10,
                                  child: Card(
                                    elevation: 8,
                                    child: Container(
                                        height: 150,
                                        width: 360,
                                        //color: Colors.red,
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0, top: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                buildButton(
                                                    text: "Dashboard",
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DashboardScrren()));
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        APIService
                                                            .onLogoutClicked(
                                                                context);
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ],
                                        )),
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
  identification(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
                padding: EdgeInsets.only(left: 10.0),
                height: 40.0,
                color: Color.fromRGBO(170, 131, 108, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Next Rank",
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
            content: FutureBuilder(
              future: APIService.getRank(),
              builder:
                  (BuildContext context, AsyncSnapshot<RankModel> snapshot) {
                if (snapshot.hasData) {
                  return Form(
                    //key: identificationkey,
                    child: ListView(
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 60,
                            width: 60,
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/11594609873.jpg",
                              image: snapshot.data.data.nextRankImage,
                            )),
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            height: 40.0,
                            width: 180.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name:"),
                                Text(snapshot.data.data.nextRank.toString()),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            height: 40.0,
                            width: 180.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Member Left:"),
                                Text(snapshot.data.data.totalMemberLeftForNext
                                    .toString()),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            height: 40.0,
                            width: 180.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Member:"),
                                Text(
                                    snapshot.data.data.totalMembers.toString()),
                              ],
                            )),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        });
  }
}
