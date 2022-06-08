import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/dashboardScreen.dart';
import 'package:swiftasset/model/KycModel.dart';
import 'package:swiftasset/sharedpreference/store.dart';

class IdentityVerificationData extends StatefulWidget {
  @override
  _IdentityVerificationDataState createState() => _IdentityVerificationDataState();
}

class _IdentityVerificationDataState extends State<IdentityVerificationData>
    with SingleTickerProviderStateMixin {
  File licensefront, licenseBack,passportId,icardFont,icardBack;
  bool selsected;
  List<String> _tabNameList = ["icard", "passport","license"];
  APIService service = APIService();
  GlobalKey<FormState> passportkey = new GlobalKey();
  GlobalKey<FormState> addresskey = new GlobalKey();
  GlobalKey<FormState> licensekey = new GlobalKey();
  GlobalKey<FormState> icardkey = new GlobalKey();
  String _selectedTabName = "Transfer";


  TabController _tabController;

  @override
  void initState() {
    super.initState();
  }


  final pickFrontIdCard = ImagePicker();
  final pickBackIdCard = ImagePicker();
  final pickPassport = ImagePicker();
  final pickFontLicense = ImagePicker();
  final pickBackLicense = ImagePicker();

  ProgressDialog pr;
  var _context;
  String type="icard";
  String passport,icard,license;

  final List<Tab> tabs = <Tab>[
    Tab(text: 'ID Card'),
    Tab(text: 'Passport'),
    Tab(text: "Driver's License"),
  ];
  Future getCameraIdcardFront() async {
    final pickedFile = await pickFrontIdCard.getImage(source: ImageSource.camera);

    setState(() {
      icardFont = File(pickedFile.path);
    });
  }
  Future getGallaryImageFontIdcard() async {
    final pickedFile = await pickFrontIdCard.getImage(source: ImageSource.gallery);

    setState(() {
      icardFont = File(pickedFile.path);
    });
  }

  Future imagegetCameraBackIdcard() async {
    final picked = await pickBackIdCard.getImage(source: ImageSource.camera);

    setState(() {
      icardBack = File(picked.path);
    });
  }
  Future imagegetGallaryBackIdCard() async {
    final picked = await pickBackIdCard.getImage(source: ImageSource.gallery);

    setState(() {
      icardBack = File(picked.path);
    });
  }
  Future imagegetCameraPassport() async {
    final pickedPassport = await pickPassport.getImage(source: ImageSource.camera);

    setState(() {
      passportId = File(pickedPassport.path);
    });
  }
  Future imagegetGallaryPassport() async {
    final pickedPassport = await pickPassport.getImage(source: ImageSource.gallery);

    setState(() {
      passportId = File(pickedPassport.path);
    });
  }
  Future imagegetCameraBackLicense() async {
    final pickedLicense = await pickBackLicense.getImage(source: ImageSource.camera);

    setState(() {
      licenseBack = File(pickedLicense.path);
    });
  }
  Future imagegetGallaryBackLicense() async {
    final pickedLicense = await pickBackLicense.getImage(source: ImageSource.gallery);

    setState(() {
      licenseBack = File(pickedLicense.path);
    });
  }
  Future imagegetCameraBackFontLicense() async {
    final pickedFontLicense = await pickFontLicense.getImage(source: ImageSource.camera);

    setState(() {
      licensefront = File(pickedFontLicense.path);
    });
  }
  Future imagegetGallaryFontLicense() async {
    final pickedFontLicense = await pickFontLicense.getImage(source: ImageSource.gallery);

    setState(() {
      licensefront = File(pickedFontLicense.path);
    });
  }

  _asyncFileUpload() async {
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
    Map<String, String> headers= {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['type'] = type.toString();
    //create multipart using filepath, string or bytes
    var icardFontPic = await http.MultipartFile.fromPath("file1", icardFont.path);
    var icardBackPic = await http.MultipartFile.fromPath("file2", icardBack.path);
    request.files.add(icardFontPic);
    request.files.add(icardBackPic);
    print(request);
    var response = await request.send();
    print(response);

    if(response.statusCode == 200 ){
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
  _passport() async {
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
    Map<String, String> headers= {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['type'] = type.toString();
    //create multipart using filepath, string or bytes
    var passportPic = await http.MultipartFile.fromPath("file1", passportId.path);
    request.files.add(passportPic);
    print(request);
    var response = await request.send();
    print(response);
    if(response.statusCode == 200 ){
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
  _license() async {
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
    Map<String, String> headers= {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['type'] = type.toString();
    //create multipart using filepath, string or bytes
    var licensePic = await http.MultipartFile.fromPath("file1", licensefront.path);
    var licensePic1 = await http.MultipartFile.fromPath("file2", licenseBack.path);
    request.files.add(licensePic);
    request.files.add(licensePic1);
    print(request);
    var response = await request.send();
    print(response);
    if(response.statusCode == 200 ){
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Choose an option:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
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
                          type="icard";

                        });

                      }
                      if(tabController.index==1){
                        setState(() {
                          type="passport";

                        });

                      }
                      if(tabController.index==2){
                        setState(() {
                          type="license";

                        });


                      }
                      print(type);

                    }
                  });
                  tabController.addListener(() {
                    if (!tabController.indexIsChanging) {
                         }
                  });
                  return FutureBuilder(
                    future: service.getKyc(),
                    builder: (BuildContext context ,AsyncSnapshot<GetKycModel>snapshot){
                      if(snapshot.hasData){
                        return Container(
                    child: Wrap(
                      children: [
                        Container(
                          child: TabBar(
                            tabs: tabs,
                            controller: _tabController,

                            unselectedLabelColor: Color.fromRGBO(39, 44, 112, 1),
                            indicator: BoxDecoration(
                              color: Color.fromRGBO(170, 131, 108, 1),
                            ),

                          ),
                        ) ,
                        Container(
                            height: 500.0,
                            child: Column(
                              children: [
                                Container(
                                  height: 500,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      Form(
                                        key:icardkey,
                                        child: Container(
                                            padding: EdgeInsets.only(top: 10),
                                            child: ListView(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "We need a copy of your",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
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
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Container(
                                                            child: CircleAvatar(
                                                              radius: 50,
                                                              child: Image.asset(
                                                                  "assets/images/address-card.png"),
                                                            )),
                                                        Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child:
                                                                    Text("Your Full Name")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text(
                                                                        "Unique document number")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child:
                                                                    Text("Date of issue")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text(
                                                                        "Full address of residence")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text(
                                                                        "Signature and stamp")),
                                                              ],
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                snapshot.data.data.personalFileType =="icard"? Container(
                                                  width: 360,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Image.network(snapshot.data.data.personalFilename,height: 100,width: 100,),
                                                      Image.network(snapshot.data.data.personalFilename2,height: 100,width: 100,),
                                                    ],
                                                  ),
                                                ):Text(""),
                                                Container(
                                                  width: 360,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      icardFont == null
                                                          ? Text("")
                                                          : Image.file(
                                                        icardFont,
                                                        height: 80,
                                                        width: 100,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                      icardBack == null
                                                          ? Text("")
                                                          : Image.file(
                                                        icardBack,
                                                        height: 80,
                                                        width: 100,
                                                        fit: BoxFit.fitHeight,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Container(
                                                      height: 100.0,
                                                      width: 100.0,
                                                      child: Container(
                                                          child: Padding(
                                                              padding:
                                                              EdgeInsets.all(1.5 / 2),
                                                              child: CustomPaint(
                                                                  painter:
                                                                  DashBorderPainter(
                                                                      color: Colors
                                                                          .grey[400],
                                                                      strokeWidth: 1.5,
                                                                      gap: 4.0),
                                                                  child: Column(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          margin: EdgeInsets
                                                                              .only(
                                                                              top:
                                                                              10.0),
                                                                          child: Container(
                                                                              height: 45.0,
                                                                              child: Center(
                                                                                  child:
                                                                                  IconButton(
                                                                                      padding: EdgeInsets.only(
                                                                                          left:
                                                                                          3.0,
                                                                                          right:
                                                                                          10.0),
                                                                                      icon:
                                                                                      Icon(
                                                                                        Icons.arrow_upward,
                                                                                        color: Color.fromRGBO(1, 94, 171, 1),
                                                                                      ),
                                                                                      onPressed:
                                                                                          () {
                                                                                        setState(() {
                                                                                          _getFontICardDialog(context);
                                                                                        });
                                                                                          })),
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius:
                                                                                  BorderRadius.circular(
                                                                                      5.0),
                                                                                  border: Border.all(
                                                                                      width:
                                                                                      2.0,
                                                                                      color: Color.fromRGBO(
                                                                                          1,
                                                                                          94,
                                                                                          171,
                                                                                          1))),
                                                                              width: 35.0),
                                                                        ),
                                                                        Text("Upload Image")
                                                                      ])))),
                                                    ),
                                                    Container(
                                                      height: 100.0,
                                                      width: 100.0,
                                                      child: Container(
                                                          child: Padding(
                                                              padding:
                                                              EdgeInsets.all(1.5 / 2),
                                                              child: CustomPaint(
                                                                  painter:
                                                                  DashBorderPainter(
                                                                      color: Colors
                                                                          .grey[400],
                                                                      strokeWidth: 1.5,
                                                                      gap: 4.0),
                                                                  child: Column(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          margin: EdgeInsets
                                                                              .only(
                                                                              top:
                                                                              10.0),
                                                                          child: Container(
                                                                              height: 45.0,
                                                                              child: Center(
                                                                                  child:
                                                                                  IconButton(
                                                                                      padding: EdgeInsets.only(
                                                                                          left:
                                                                                          3.0,
                                                                                          right:
                                                                                          10.0),
                                                                                      icon:
                                                                                      Icon(
                                                                                        Icons.arrow_upward,
                                                                                        color: Color.fromRGBO(1, 94, 171, 1),
                                                                                      ),
                                                                                      onPressed:
                                                                                          () {
                                                                                        setState(() {
                                                                                          _showIcardBackDialog(context);
                                                                                        });
                                                                                          })),
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius:
                                                                                  BorderRadius.circular(
                                                                                      5.0),
                                                                                  border: Border.all(
                                                                                      width:
                                                                                      2.0,
                                                                                      color: Color.fromRGBO(
                                                                                          1,
                                                                                          94,
                                                                                          171,
                                                                                          1))),
                                                                              width: 35.0),
                                                                        ),
                                                                        Text("Upload Image")
                                                                      ])))),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10.0, bottom: 15.0),
                                                  child: Center(
                                                    child: new RaisedButton(
                                                      onPressed: () {
                                                        final loginForm = icardkey.currentState;

                                                        if (loginForm.validate()) {
                                                          loginForm.save();
                                                          _asyncFileUpload();
                                                        } else {
                                                          print("rrrrrrr");
                                                        }
                                                      },
                                                      color: Colors.orange,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                          new BorderRadius.circular(
                                                              30.0)),
                                                      child: new Text('Submit',
                                                          style: new TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.bold)),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 150,),
                                              ],
                                            )),
                                      ),
                                      Form(
                                        key: passportkey,
                                        child: Container(
                                            padding: EdgeInsets.only(top: 10),
                                            child: ListView(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "We need a copy of your",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
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
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Container(
                                                            child: CircleAvatar(
                                                              radius: 50,
                                                              child: Image.asset(
                                                                  "assets/images/address-card.png"),
                                                            )),
                                                        Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child:
                                                                    Text("Your Full Name")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text(
                                                                        "Unique document number")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child:
                                                                    Text("Date of issue")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text(
                                                                        "Full address of residence")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text(
                                                                        "Signature and stamp")),
                                                              ],
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                 snapshot.data.data.personalFileType =="passport"? Container(
                                                  width: 360,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Image.network(snapshot.data.data.personalFilename,height: 100,width: 100,),
                                                      Image.network(snapshot.data.data.personalFilename2,height: 100,width: 100,),
                                                    ],
                                                  ),
                                                ):Text(""),
                                                Container(
                                                  width: 360,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      passportId == null
                                                          ? Text("")
                                                          : Image.file(
                                                        passportId,
                                                        height: 80,
                                                        width: 100,
                                                        fit: BoxFit.fitHeight,
                                                      ),
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
                                                            padding:
                                                            EdgeInsets.all(1.5 / 2),
                                                            child: CustomPaint(
                                                                painter: DashBorderPainter(
                                                                    color: Colors.grey[400],
                                                                    strokeWidth: 1.5,
                                                                    gap: 4.0),
                                                                child: Column(
                                                                    children: <Widget>[
                                                                      Container(
                                                                        margin:
                                                                        EdgeInsets.only(
                                                                            top: 10.0),
                                                                        child: Container(
                                                                            height: 45.0,
                                                                            child: Center(
                                                                                child:
                                                                                IconButton(
                                                                                    padding: EdgeInsets.only(
                                                                                        left:
                                                                                        3.0,
                                                                                        right:
                                                                                        10.0),
                                                                                    icon:
                                                                                    Icon(
                                                                                      Icons.arrow_upward,
                                                                                      color: Color.fromRGBO(1, 94, 171, 1),
                                                                                    ),
                                                                                    onPressed:
                                                                                        () {
                                                                                      setState(() {
                                                                                        _showPassportDialog(context);
                                                                                      });

                                                                                    })),
                                                                            decoration: BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius.circular(
                                                                                    5.0),
                                                                                border: Border.all(
                                                                                    width:
                                                                                    2.0,
                                                                                    color: Color.fromRGBO(
                                                                                        1,
                                                                                        94,
                                                                                        171,
                                                                                        1))),
                                                                            width: 35.0),
                                                                      ),
                                                                      Text("Upload Image")
                                                                    ])))),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10.0, bottom: 15.0),
                                                  child: Center(
                                                    child: new RaisedButton(
                                                      onPressed: () {
                                                        final loginForm = passportkey.currentState;

                                                        if (loginForm.validate()) {
                                                          loginForm.save();
                                                          _passport();
                                                        } else {
                                                          print("rrrrrrr");
                                                        }
                                                      },
                                                      color: Colors.orange,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                          new BorderRadius.circular(
                                                              30.0)),
                                                      child: new Text('Submit',
                                                          style: new TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.bold)),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 150,),
                                              ],
                                            )),
                                      ),
                                      Form(
                                        key: licensekey,
                                        child: Container(
                                            padding: EdgeInsets.only(top: 10),
                                            child: ListView(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "We need a copy of your",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
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
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Container(
                                                            child: CircleAvatar(
                                                              radius: 50,
                                                              child: Image.asset(
                                                                  "assets/images/address-card.png"),
                                                            )),
                                                        Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child:
                                                                    Text("Your Full Name")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text(
                                                                        "Unique document number")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child:
                                                                    Text("Date of issue")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text(
                                                                        "Full address of residence")),
                                                                Container(
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text(
                                                                        "Signature and stamp")),
                                                              ],
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                 snapshot.data.data.personalFileType =="license"? Container(
                                                  width: 360,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Image.network(snapshot.data.data.personalFilename,height: 100,width: 100,),
                                                      Image.network(snapshot.data.data.personalFilename2,height: 100,width: 100,),
                                                    ],
                                                  ),
                                                ):Text(""),
                                                Container(
                                                  width: 360,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      licensefront == null
                                                          ? Text("")
                                                          : Image.file(
                                                        licensefront,
                                                        height: 80,
                                                        width: 100,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                      licenseBack == null
                                                          ? Text("")
                                                          : Image.file(
                                                        licenseBack,
                                                        height: 80,
                                                        width: 100,
                                                        fit: BoxFit.fitHeight,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Container(
                                                      height: 100.0,
                                                      width: 100.0,
                                                      child: Container(
                                                          child: Padding(
                                                              padding:
                                                              EdgeInsets.all(1.5 / 2),
                                                              child: CustomPaint(
                                                                  painter:
                                                                  DashBorderPainter(
                                                                      color: Colors
                                                                          .grey[400],
                                                                      strokeWidth: 1.5,
                                                                      gap: 4.0),
                                                                  child: Column(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          margin: EdgeInsets
                                                                              .only(
                                                                              top:
                                                                              10.0),
                                                                          child: Container(
                                                                              height: 45.0,
                                                                              child: Center(
                                                                                  child:
                                                                                  IconButton(
                                                                                      padding: EdgeInsets.only(
                                                                                          left:
                                                                                          3.0,
                                                                                          right:
                                                                                          10.0),
                                                                                      icon:
                                                                                      Icon(
                                                                                        Icons.arrow_upward,
                                                                                        color: Color.fromRGBO(1, 94, 171, 1),
                                                                                      ),
                                                                                      onPressed:
                                                                                          () {
                                                                                        setState(() {
                                                                                    _showLicenseFont(context);
                                                                                        });
                                                                                      })),
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius:
                                                                                  BorderRadius.circular(
                                                                                      5.0),
                                                                                  border: Border.all(
                                                                                      width:
                                                                                      2.0,
                                                                                      color: Color.fromRGBO(
                                                                                          1,
                                                                                          94,
                                                                                          171,
                                                                                          1))),
                                                                              width: 35.0),
                                                                        ),
                                                                        Text("Upload Image")
                                                                      ])))),
                                                    ),
                                                    Container(
                                                      height: 100.0,
                                                      width: 100.0,
                                                      child: Container(
                                                          child: Padding(
                                                              padding:
                                                              EdgeInsets.all(1.5 / 2),
                                                              child: CustomPaint(
                                                                  painter:
                                                                  DashBorderPainter(
                                                                      color: Colors
                                                                          .grey[400],
                                                                      strokeWidth: 1.5,
                                                                      gap: 4.0),
                                                                  child: Column(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          margin: EdgeInsets
                                                                              .only(
                                                                              top:
                                                                              10.0),
                                                                          child: Container(
                                                                              height: 45.0,
                                                                              child: Center(
                                                                                  child:
                                                                                  IconButton(
                                                                                      padding: EdgeInsets.only(
                                                                                          left:
                                                                                          3.0,
                                                                                          right:
                                                                                          10.0),
                                                                                      icon:
                                                                                      Icon(
                                                                                        Icons.arrow_upward,
                                                                                        color: Color.fromRGBO(1, 94, 171, 1),
                                                                                      ),
                                                                                      onPressed:
                                                                                          () {
                                                                                        setState(() {
                                                                                          ShowLicenseBack(context);
                                                                                        });
                                                                                      })),
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius:
                                                                                  BorderRadius.circular(
                                                                                      5.0),
                                                                                  border: Border.all(
                                                                                      width:
                                                                                      2.0,
                                                                                      color: Color.fromRGBO(
                                                                                          1,
                                                                                          94,
                                                                                          171,
                                                                                          1))),
                                                                              width: 35.0),
                                                                        ),
                                                                        Text("Upload Image")
                                                                      ])))),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10.0, bottom: 15.0),
                                                  child: Center(
                                                    child: new RaisedButton(
                                                      onPressed: () {
                                                        final loginForm = licensekey.currentState;

                                                        if (loginForm.validate()) {
                                                          loginForm.save();
                                                          _license();

                                                        } else {
                                                          print("rrrrrrr");
                                                        }


                                                      },
                                                      color: Colors.orange,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                          new BorderRadius.circular(
                                                              30.0)),
                                                      child: new Text('Submit',
                                                          style: new TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.bold)),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 150,),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  );
                      }else{
                        return Center(
                          child: CircularProgressIndicator()
                        );
                      }
                    },
                  );
                }),
              ),
            )


          ],
        ),
      ),
    );


  }


  Future<void> _showLicenseFont(BuildContext context) {
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
               imagegetGallaryFontLicense();
                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        imagegetCameraBackFontLicense();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
  Future<void> _getFontICardDialog(BuildContext context) {
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
                        getGallaryImageFontIdcard();
                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        getCameraIdcardFront();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
  Future<void> _showIcardBackDialog(BuildContext context) {
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
                       imagegetGallaryBackIdCard();


                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                       imagegetCameraBackIdcard();

                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
  Future<void> _showPassportDialog(BuildContext context) {
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
                     imagegetGallaryPassport();
                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                      imagegetGallaryPassport();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
  Future<void> ShowLicenseBack(BuildContext context) {
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
                       imagegetGallaryBackLicense();
                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        imagegetCameraBackLicense();
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