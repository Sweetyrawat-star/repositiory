
import 'package:flutter/material.dart';
import 'package:swiftasset/Profile.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/dashboardScreen.dart';
import 'package:swiftasset/model/MyPackageModel.dart';
import 'package:swiftasset/webview.dart';

class PackagePage extends StatefulWidget {
  @override
  _PackagePageState createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  String token;
  String packagrTime, packageName, packageImage, packageDate,packageAmount;
  @override
  void initState() {
    super.initState();
    APIService.getMyPackage();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color.fromRGBO(170, 131, 108,1),
      body: Container(
         height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Color.fromRGBO(105, 111, 119,1),Color.fromRGBO(170, 131, 108,1)])),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
               Column(
                 children: <Widget>[
                   AppBar(
                     centerTitle: true,
                     backgroundColor: Colors.transparent,
                     elevation: 0.0 ,
                     title:  Text("Package",
                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                              ),
                   ),
                 Container(
                   height: MediaQuery.of(context).size.height-50,
                   child: FutureBuilder<MyPackageModel>(
                future: APIService.getMyPackage(),
                builder: ( context ,snapshot){
                if(snapshot.hasData){
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 60,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight:Radius.circular(10.0), ),
                          ),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 10,
                        left: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10.0,bottom: 10),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                                elevation: 8,
                                child: Row(
                                  children: <Widget>[
                                    snapshot.data.data.packageImage.toString() == null ? Image.asset("assets/images/citizen1.png",
                                      width: 120,
                                    ):Image.network(snapshot.data.data.packageImage.toString() ,width: 110,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Product Name: ",
                                              style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
                                            ),
                                            snapshot.data.data.packageName.toString()  == null? Text(""):  Text( snapshot.data.data.packageName.toString() ,
                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text("Date: ",
                                                    style: TextStyle(fontSize: 17,color: Colors.grey),
                                                  ),
                                                  snapshot.data.data.packageDate.toString()  == null? Text(""): Text(snapshot.data.data.packageDate.toString().replaceAll("00:00:00.000", "")    ,
                                                    style: TextStyle(fontSize: 15,color: Colors.grey,),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text("Time: ",
                                                    style: TextStyle(fontSize: 18,color: Colors.grey),
                                                  ),
                                                  snapshot.data.data.packageTime.toString() ==null? Text("") :Text( snapshot.data.data.packageTime.toString().replaceAll("00:00:00.000", "") ,
                                                    style: TextStyle(fontSize: 16,color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2,),
                                              snapshot.data.data.packageAmount.toString()  ==null? Text(""): Text( snapshot.data.data.packageAmount.toString() ,
                                                style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Positioned(
                        top: 170,
                        left: 10,
                        right: 10,
                        child: Card(
                          elevation: 8,
                          child: Container(
                              height: 150,
                              width: 360,
                              padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      buildButton(text: "Dashboard", onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScrren()));

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
                    ],
                  );
                }else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                }

                   ),
                 )

                 ],
               ),
            ],
          )
      ),
        
    );
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