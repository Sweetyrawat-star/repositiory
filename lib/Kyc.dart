import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:swiftasset/Addressverification.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/indentification.dart';

class KycPage extends StatefulWidget {
  @override
  _KycPageState createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> {
   String type="identification";
    APIService service = APIService();
    final List<Tab> tabs = <Tab>[
   Tab(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Identity Verification",
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Address Verification",
                                  ),
                                ),
                              ),
                            ),
  ];
  TabController _tabController;
 

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
              //physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  // new Image.asset(
                  //   'assets/images/b-c2.png',
                  //   fit: BoxFit.cover,
                  // ),
                  Column(
                      children: <Widget>[
                        AppBar(
                          centerTitle: true,
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          // leading: Icon(Icons.arrow_back),
                          title: Text(
                            "Kyc",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height-50,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // buildMyPackage(),
                                Positioned(
                                  top: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight:Radius.circular(10.0), ),
                                    ),
                                    height: 600,
                                    //color: Colors.white,
                                    width: 360,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child:   Padding(
                                    padding: const EdgeInsets.all(10.0),
                                   child:  Container(
                                        height: 650,
                                       width: MediaQuery.of(context).size.width,
                                     child: Card(
                                       elevation: 8,
                                         child: DefaultTabController(
                                          length: tabs.length,
                                          initialIndex: 0,
                                          child: Builder(builder: (BuildContext context) {
                                            final TabController tabController = DefaultTabController.of(context);
                                            tabController.addListener(() {
                                              if (!tabController.indexIsChanging) {
                                                print( tabController.index);
                                                if(tabController.index==0){
                                                  setState(() {
                                                    type="identification";

                                                  });

                                                }
                                                if(tabController.index==1){
                                                  setState(() {
                                                    type="address";

                                                  });

                                                }
                                              
                                                print(type);

                                              }
                                            });
                                            tabController.addListener(() {
                                              if (!tabController.indexIsChanging) {
                                                   }
                                            });
                                          
                                                  return Container(
                                              child: Wrap(
                                                children: [
                                                  Container(
                                                    child: TabBar(
                                                      tabs: tabs,
                                                      controller: _tabController,

                                                      unselectedLabelColor: Color.fromRGBO(39, 44, 112, 1),
                                                      indicator: BoxDecoration(
                                                        // borderRadius: BorderRadius.circular(50),
                                                        color: Color.fromRGBO(170, 131, 108, 1),
                                                      ),

                                                    ),
                                                  ) ,
                                                  Container(
                                                                    // color: Colors.grey,
                                                                      height: 650.0,
                                                                      child: TabBarView(
                                                                        children: [
                                                                         // MyTabbedPage(),
                                                                          IdentityVerificationData(),
                                                                          AddressVerification(),

                                                                        ],
                                                                      ))
                                                ],
                                              ),
                                            );
                                                
                                            
                                          }),
                                        ),
                                     ),
                                   )                                   
                                  ),
                                ),
                                SizedBox(height: 20,),
                        
                              ],)

                        )])])));

   
  }
}

class DashedRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRect(
      {this.color = Colors.black, this.strokeWidth = 1.0, this.gap = 5.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(strokeWidth / 2),
        child: CustomPaint(
          painter:
              DashRectPainter(color: color, strokeWidth: strokeWidth, gap: gap),
        ),
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    @required math.Point<double> a,
    @required math.Point<double> b,
    @required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x, currentPoint.y)
          : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
