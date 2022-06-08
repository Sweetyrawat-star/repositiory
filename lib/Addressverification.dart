import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/dashboardScreen.dart';
import 'package:swiftasset/model/KycModel.dart';
import 'package:swiftasset/sharedpreference/store.dart';

class AddressVerification extends StatefulWidget {
  @override
  _AddressVerificationState createState() => _AddressVerificationState();
}

class _AddressVerificationState extends State<AddressVerification>
    with SingleTickerProviderStateMixin {
  File address;
  ProgressDialog pr;
  String type = "identification";
  GlobalKey<FormState> addresskey = new GlobalKey();
  final pickFrontIdCard = ImagePicker();
  final pickBackIdCard = ImagePicker();
  APIService service = APIService();
  Future getCameraAddress() async {
    final pickedFile =
        await pickFrontIdCard.getImage(source: ImageSource.camera);

    setState(() {
      address = File(pickedFile.path);
    });
  }

  Future getGallaryImageAddrss() async {
    final pickedFile =
        await pickFrontIdCard.getImage(source: ImageSource.gallery);

    setState(() {
      address = File(pickedFile.path);
    });
  }

  _address() async {
    setState(() {
      pr.show();
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    //create multipart request for POST or PATCH method
    final String url = "http://dev.swiftassets.net/public/api/upload_docs";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // var request = http.MultipartRequest
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['type'] = type.toString();
    //create multipart using filepath, string or bytes
    var passportPic = await http.MultipartFile.fromPath("file1", address.path);
    request.files.add(passportPic);
    print(request);
    var response = await request.send();
    print(response);
    if (response.statusCode == 200) {
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardScrren()));
    }
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return FutureBuilder(
      future: service.getKyc(),
      builder: (BuildContext context, AsyncSnapshot<GetKycModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
              padding: EdgeInsets.only(top: 10),
              child: Form(
                key: addresskey,
                child: ListView(
                  children: [
                    Text(
                      "We need a copy of your",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        height: 30,
                        child: ListTile(
                          leading: Icon(Icons.done_outline),
                          title: Text("Utility Bill"),
                        )),
                    Container(
                        height: 30,
                        child: ListTile(
                          leading: Icon(Icons.done_outline),
                          title: Text("Bank Statement"),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "In order to verify your address",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ExpansionTileCard(
                      title: Text("Explanation"),
                      children: [
                        Text(
                            "A copy of valid Utility Bill and Bank Statement is required in order of us to verify your address.The document you submit as proof of address shoul contain following information"),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                child: CircleAvatar(
                              radius: 50,
                              child:
                                  Image.asset("assets/images/address-card.png"),
                            )),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text("Your Full Name")),
                                Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text("Unique document number")),
                                Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text("Date of issue")),
                                Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text("Full address of residence")),
                                Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text("Signature and stamp")),
                              ],
                            ))
                          ],
                        )
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    snapshot.data.data.addressFileType != "address"
                        ? Text("")
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.network(
                                  snapshot.data.data.addressFile1,
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                    //:Text(""),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          address != null
                              ? Image.file(
                                  address,
                                  height: 80,
                                  width: 100,
                                  fit: BoxFit.fitHeight,
                                )
                              : Text(""),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        child: Container(
                            child: Padding(
                                padding: EdgeInsets.all(1.5 / 2),
                                child: CustomPaint(
                                    painter: DashBorderPainter(
                                        color: Colors.grey[400],
                                        strokeWidth: 1.5,
                                        gap: 4.0),
                                    child: Column(children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: Container(
                                            height: 45.0,
                                            child: Center(
                                                child: IconButton(
                                                    padding: EdgeInsets.only(
                                                        left: 3.0, right: 10.0),
                                                    icon: Icon(
                                                      Icons.arrow_upward,
                                                      color: Color.fromRGBO(
                                                          1, 94, 171, 1),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _showAddressDialog(
                                                            context);
                                                      });
                                                    })),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                    width: 2.0,
                                                    color: Color.fromRGBO(
                                                        1, 94, 171, 1))),
                                            width: 35.0),
                                      ),
                                      Text("Upload Image")
                                    ])))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                      child: Center(
                        child: new RaisedButton(
                          onPressed: () {
                            final loginForm = addresskey.currentState;

                            if (loginForm.validate()) {
                              loginForm.save();
                              _address();
                            } else {
                              print("rrrrrrr");
                            }

                            print('Login Pressed');
                          },
                          color: Colors.orange,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: new Text('Submit',
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    SizedBox(height: 150),
                  ],
                ),
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> _showAddressDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to choose the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        getGallaryImageAddrss();
                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        getCameraAddress();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
}

class DashBorderPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashBorderPainter(
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
