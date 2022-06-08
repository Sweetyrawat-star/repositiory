import 'package:flutter/material.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/Profile.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/model/ApprovedModel.dart';
import 'package:swiftasset/webview.dart';

class ApprovedPage extends StatefulWidget {
  @override
  _ApprovedPageState createState() => _ApprovedPageState();
}

class _ApprovedPageState extends State<ApprovedPage> {
   APIService service = APIService();

   
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
                      // leading: Icon(Icons.arrow_back),
                      title:  Text("Approved",
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                      ),

                    ),
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                          future: service.getApproved(),
                          builder: (BuildContext context ,AsyncSnapshot<ApprovedModel>snapshot){
                          if(snapshot.hasData){
                            return Stack(
                              fit: StackFit.expand,
                              children: [
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
                                  top: 10,
                                  right: 0,
                                  left: 0,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                                        Text("Total Approved",
                                                          style: TextStyle(fontSize: 18),
                                                        ),

                                                        snapshot.data.data.totalWithdraw.toString() == null ? Text(""): Text(snapshot.data.data.totalWithdraw.toString(),
                                                          style: TextStyle(fontSize: 15,color: Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Image.asset("assets/images/citizen1.png",
                                                    width: 120,
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      )


                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Positioned(
                                  top: 140,
                                  left: 10,
                                  right: 10,
                                  child: Card(
                                    elevation: 8,
                                    child: Container(
                                        height: 150,
                                       width: MediaQuery.of(context).size.width,
                                        //color: Colors.red,
                                        padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                buildButton(text: "Dashboard", onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()));

                                                }),
                                                buildButton(text: "Profile", onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                                                }),
                                              ],
                                            ),
                                            SizedBox(height: 20,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                buildButton(text: "Network", onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> WebsitePage()));

                                                }),
                                                buildButton(text: "LogOut", onTap: () {
                                                  setState(() {
                                                    APIService.onLogoutClicked(context);
                                                  });
                                                }),
                                              ],
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                )
                                //CustomCard.buildButton(context: context)
                              ],
                            );
                          }else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          }


                        ))
                  ])
                ])));
  }
  buildButton({String text, onTap}){
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