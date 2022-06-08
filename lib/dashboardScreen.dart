
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:swiftasset/Drawer.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/model/DashbordModel.dart';
import 'package:swiftasset/model/GetBannerModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardScrren extends StatefulWidget {
  @override
  _DashboardScrrenState createState() => _DashboardScrrenState();
}

class _DashboardScrrenState extends State<DashboardScrren> {
  List data;
  DateTime backbuttonpressedTime;
   
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: onWillPop,
          child: Scaffold(
          backgroundColor: Color.fromRGBO(170, 131, 108,1),
          drawer: InkWellDrawer(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Color.fromRGBO(105, 111, 119,1),Color.fromRGBO(170, 131, 108,1)])),
            child: Stack(
              children: <Widget>[
                Positioned(
                  // --> App Bar
                  child: ListView(
                    children: <Widget>[
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        actions: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 10,top: 15),
                              width: MediaQuery.of(context).size.width,

                              child:  Padding(
                                padding: EdgeInsets.only(left:120),
                                child: Text("Dashboard",
                                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                ),
                              )
                          )
                        ],
                      ),
                      FutureBuilder<DashBoardModel>(
                        future: APIService.getDashBoard(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            double data = double.parse((snapshot.data.data.propertyRewardProgress
                            ).toStringAsFixed(1))/100;
                            print(data);
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        width: 170.0,
                                        child: Card(
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset("assets/images/weeksclosing.png"),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("WEEK 10 CLOSING",
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                    SizedBox(height: 2.0,),
                                                    Row(
                                                      children: [
                                                        snapshot.data.data.days.toString() == null ?Text(""): Row(
                                                          children: [

                                                            Text(snapshot.data.data.days.toString(),style: TextStyle(
                                                                fontSize: 10

                                                            ),),
                                                            Text("days, ",style: TextStyle(fontSize: 10),),
                                                          ],
                                                        ),
                                                        snapshot.data.data.hours.toString() == null ? Text(""): Row(
                                                          children: [
                                                            Text(snapshot.data.data.hours.toString(),style: TextStyle(
                                                                fontSize: 10
                                                            ),),
                                                            Text("hours ",style: TextStyle(fontSize: 10),),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    snapshot.data.data.minutes.toString()  == null ? Text(""): Row(
                                                      children: [
                                                        Text("& ",style: TextStyle(fontSize: 10),),
                                                        Text(snapshot.data.data.minutes.toString(),style: TextStyle(
                                                            fontSize: 8
                                                        ),),
                                                        Text("mintues ",style: TextStyle(fontSize: 10),),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        width: 170.0,
                                        child:  Card(
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset("assets/images/newjoinings.png"),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("New Joinings",
                                                      style: TextStyle(fontSize: 13),
                                                    ),
                                                    Text("0 Users",
                                                      style: TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                        ),
                                      )
                                    ],),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        width: 170.0,
                                        child:  Card(
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset("assets/images/servertime.png"),
                                                Column(

                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("Server Time",
                                                      style: TextStyle(fontSize: 13),
                                                    ),
                                                    snapshot.data.data.serverTime.toString() == null ? Text(""):
                                                    Text(snapshot.data.data.serverTime.toString().replaceAll(".000", ""),
                                                      style: TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        width: 170.0,
                                        child:  Card(
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset("assets/images/logout.png"),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("Automatic Logout In",
                                                      style: TextStyle(fontSize: 13),
                                                    ),
                                                    Text("WEEK 10 CLOSING IN",
                                                      style: TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                        ),
                                      )
                                    ],),
                                ),                               
                                buildCarousal(),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        height: 120,
                                        width: 170.0,
                                        child: Card(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                               snapshot.data.data.rankImage.toString() == null? Image.asset("assets/images/citizen1.png",
                                                   height:60,
                                                   width: 100,
                                                   ):
                                               Image.network( snapshot.data.data.rankImage.toString(),
                                                  height:60,
                                                  width: 100,
                                                ),
                                                Text("CURRENT RANK"),
                                                snapshot.data.data.rank.toString() == null? Text(""):Text(snapshot.data.data.rank.toString(),
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                      Container(
                                        height: 120,
                                        width: 170.0,
                                        child: Card(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                snapshot.data.data.nextRankImage.toString() == null?
                                                Image.asset("assets/images/sapphire.png",
                                                  height:60,
                                                  width: 100,
                                                ):
                                                Image.network( snapshot.data.data.nextRankImage.toString(),
                                                  height:60,
                                                  width: 100,
                                                ),
                                                   Text("Next RANK"),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                snapshot.data.data.nextRank.toString()== null? Text("") :
                                                      Text(snapshot.data.data.nextRank.toString(),
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                        ),
                                      )
                                    ],),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        height: 120,
                                        width: 170.0,
                                        child: Card(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                 snapshot.data.data.packageImage.toString() == null? Image.asset("assets/images/ruby.png",
                                                  height:60,
                                                  width: 100,
                                                ):Image.network(snapshot.data.data.packageImage.toString(),
                                                  height:60,
                                                  width: 100,
                                                ) ,
                                                Text("CURRENT PACKAGE",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                snapshot.data.data.packageName.toString() == null? Text("")
                                                :Text(  snapshot.data.data.packageName.toString(),
                                                  style: TextStyle(fontSize: 15),
                                                ),                                           
                                              ],
                                            )
                                        ),
                                      ),
                                      Container(
                                        height: 120,
                                        width: 170.0,
                                        child:Card(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("YOU NEED",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                    snapshot.data.data.youNeed.toString()== null? 
                                                    Text(""):Text(snapshot.data.data.youNeed.toString(),
                                                        style: TextStyle(fontSize: 12),
                                                      ),
                                                      Text("BV Points to",
                                                        style: TextStyle(fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Text("get the Next Rank",
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                      ),
                                    ],
                                    ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 75,
                                        width: 100,
                                        color:Color.fromRGBO(105, 111, 119,1),
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: <Widget>[
                                            Text("Total Earning",
                                              style: TextStyle(fontSize: 12,color: Colors.white),
                                            ),
                                            snapshot.data.data.totalEarning.toString() == null ? Text(""): Text(snapshot.data.data.totalEarning.toString(),
                                              style: TextStyle(fontSize: 12,color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 75,
                                        width: 120,
                                        color:Color.fromRGBO(105, 111, 119,1),
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: <Widget>[
                                            Text("Personal business",
                                              style: TextStyle(fontSize: 12,color: Colors.white),
                                            ),
                                            Text("volume(PBV)",
                                              style: TextStyle(fontSize: 12,color: Colors.white),
                                            ),
                                            snapshot.data.data.pbv.toString() ==null? Text(""): Text("\$${snapshot.data.data.pbv.toString()}",
                                              style: TextStyle(fontSize: 12,color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 75,
                                        width: 105,
                                        color:Color.fromRGBO(105, 111, 119,1),
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: <Widget>[
                                            Text("Team Business",
                                              style: TextStyle(fontSize: 12,color: Colors.white),
                                            ),
                                            Text("VOLUME(TBV)",
                                              style: TextStyle(fontSize: 12,color: Colors.white),
                                            ),
                                            snapshot.data.data.tbv.toString() ==null? Text(""): Text("\$${snapshot.data.data.tbv.toString()}",
                                              style: TextStyle(fontSize: 12,color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      height: 75,
                                      width: 100,
                                      color:Color.fromRGBO(105, 111, 119,1),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Text("Personal",
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                          Text("Sponsers",
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                          snapshot.data.data.personalSponsers.toString() == null ? Text(""): Text(snapshot.data.data.personalSponsers.toString(),
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 75,
                                      width: 100,
                                      color:Color.fromRGBO(105, 111, 119,1),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Text("Total Team",
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                          Text("Membership",
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                          snapshot.data.data.totalMembers.toString() == null? Text(""): Text(snapshot.data.data.totalMembers.toString(),
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 75,
                                      width: 130,
                                      color:Color.fromRGBO(105, 111, 119,1),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Text("Payout History",
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                          Text("Payout History",
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      width: 120,
                                      height: 100,
                                      color:Color.fromRGBO(105, 111, 119,1),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Total Member left",
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                          Text("for property rewards",
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                          snapshot.data.data.totalMemberLeftForProperty.toString() == null ?

                                          Text(""): Text(snapshot.data.data.totalMemberLeftForProperty.toString(),
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 100,
                                      color:Color.fromRGBO(105, 111, 119,1),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Text("Geneology",
                                            style: TextStyle(fontSize: 12,color: Colors.white),
                                          ),
                                          Text("Member for",
                                            style: TextStyle(fontSize: 12,color: Colors.red),
                                          ),
                                          Text(" qualification",
                                            style: TextStyle(fontSize: 12,color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 50,
                                    color: Colors.red,
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        snapshot.data.data.myReferalUrl.toString() == null ? Text(""): Text(snapshot.data.data.myReferalUrl.toString()
                                          ,style: TextStyle(color: Colors.black,fontSize: 9),),
                                        GestureDetector(
                                            onTap: (){
                                              FlutterClipboard.copy(snapshot.data.data.myReferalUrl.toString()).then((result) {
                                                final snackBar = SnackBar(
                                                  content: Text(snapshot.data.data.myReferalUrl.toString()),
                                                  action: SnackBarAction(
                                                    label: 'Undo',
                                                    onPressed: () {},
                                                  ),
                                                );
                                                Scaffold.of(context).showSnackBar(snackBar);
                                              });
                                            },
                                            child: Text("copy",style: TextStyle(color: Colors.black,fontSize: 15),)),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        height: 80,
                                        width: 160.0,
                                        child: Card(
                                            child: Column(

                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[

                                                Text("Commission Vault",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                snapshot.data.data.commissionVault.toString() == null ?
                                                Text(""): Text(snapshot.data.data.commissionVault.toString(),
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                      Container(
                                        height: 80,
                                        width: 160.0,
                                        child: Card(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text("Property Vault",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                snapshot.data.data.propertyVault.toString() == null?Text(""):
                                                Text(snapshot.data.data.propertyVault.toString(),
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            )
                                        ),
                                      )
                                    ],),
                                ),
                                SizedBox(height: 20.0,),
                                Container(
                                  height: 210,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                      color: Colors.white,
                                      elevation: 6.0,
                                      margin: EdgeInsets.only(right: 15.0, left: 15.0,bottom: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 140,
                                            width: 125,
                                            margin: EdgeInsets.only(right: 15.0, left: 4.0,bottom: 10),
                                            decoration: BoxDecoration(
                                              border: Border(right: BorderSide()),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,bottom: 3),
                                                  child: Text("Property Reward Progress"),
                                                ),
                                                CircularPercentIndicator(
                                                  radius: 80.0,
                                                  lineWidth: 7.0,
                                                  animation: true,
                                                  percent: data  ,
                                                  center: snapshot.data.data.propertyRewardProgress.toString() == null? Text(""): Text(
                                                    snapshot.data.data.propertyRewardProgress.toString(),
                                                    style:
                                                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Colors.grey),
                                                  ),
                                                  footer: Padding(
                                                    padding: const EdgeInsets.only(left: 60.0),
                                                    child: snapshot.data.data.packageAmount == null ? Text("") :Text(
                                                      "300.0",
                                                      style:
                                                      new TextStyle( fontSize: 15.0),
                                                    ),
                                                  ),
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  progressColor: Colors.yellow,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:10,bottom:10),
                                            height: 120,
                                            width: 1,
                                            color: Colors.white,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(top: 20.0),
                                                child: Text("Property value in 3 years"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child:snapshot.data.data.propertyValueIn3Year.toString()  == null? Text(""):Row(
                                                  children: [
                                                    Text(snapshot.data.data.propertyValueIn3Year.toString()),
                                                    Text("  Max"),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Container(
                                                margin: EdgeInsets.only(top:5),
                                                height: 1,width:160,color: Colors.grey,),
                                              SizedBox(height: 20,),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text("Alternate Cash Reward"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: snapshot.data.data.alternateCashReward.toString() == null? Text(""):Row(
                                                  children: [
                                                    Text(snapshot.data.data.alternateCashReward.toString()),
                                                    Text(" Max"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(
                                  height: 210,
                                  width: MediaQuery.of(context).size.width,
                                  child: new Card(
                                      color: Colors.white,
                                      elevation: 6.0,
                                      margin: EdgeInsets.only(right: 15.0, left: 15.0,bottom: 10),
                                      child: Row(
                                        children: <Widget>[
                                           Container(
                                           margin: EdgeInsets.only(left: 5),
                                         height: 100,
                                         width: 80,
                                                      child:
                                                      FadeInImage.assetNetwork(
                                              placeholder: "assets/images/11594609873.jpg",
                                              image: snapshot.data.data.image,
                                            )
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:10,bottom: 10,right: 10),
                                            height: 120,
                                            width: 1,
                                            color: Colors.white,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text("User Information"),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top:5),
                                                  height: 1,width:200,color: Colors.grey,),
                                                SizedBox(height: 10,),
                                                snapshot.data.data.name.toString() !=null ? 
                                                Text(snapshot.data.data.name.toString(),style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                )):Text(""),
                                               
                                               Row(
                                               children: [
                                                 Text("Email: "),
                                                 SizedBox(
                                                 width: 190.0,
                                                 child:  snapshot.data.data.email.toString() != null?
                                                 Text(snapshot.data.data.email.toString(),
                                                   maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ):Text(""),
                                                 ),
                                              
                                               ],
                                                  ),
                                                Row(
                                                  children: [
                                                    Text("Mobile: "),
                                                    snapshot.data.data.mobile.toString()!=null?
                                                    Text(snapshot.data.data.mobile.toString(),overflow: TextOverflow.ellipsis,):
                                                     Text("")
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Country: "),
                                                    snapshot.data.data.countryName.toString()!=null?
                                                    Text(snapshot.data.data.countryName.toString(),overflow: TextOverflow.ellipsis,):
                                                    Text(""),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child: Text("Sponser Details"),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top:5),
                                                  height: 1,width:200,color: Colors.grey,),
                                                Text("Sponser By:  Individual"),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
 buildCarousal(){
   return  FutureBuilder(
     future: APIService.getBanner(),
     builder: (BuildContext context,AsyncSnapshot<GetBanner>snapshot){
       if(snapshot.hasData){
         return Container(
           child: CarouselSlider.builder(
             itemCount: snapshot.data.data.banners.length,
             options: CarouselOptions(
               height: 100,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
             ),
             itemBuilder: (context, index) {
               return Container(
                 child: Center(
               child: Image.network(snapshot.data.data.banners[index].image, fit: BoxFit.cover, width: 360,height: 200,)
                 ),
               );
             },
           ),
         );
       }else{
         return Center(
             child: CircularProgressIndicator());
       }
     },
   );
 }
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    //Statement 1 Or statement2

    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Double Click to exit app",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    return true;
  }
        
      
    
  }
