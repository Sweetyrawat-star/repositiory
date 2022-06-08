import 'dart:convert';
import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/dashboardScreen.dart';
import 'package:swiftasset/model/ProfileModel.dart';
import 'package:swiftasset/sharedpreference/store.dart';
import 'package:swiftasset/webview.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String token, url;
  File _image;
  String _quantity;
 String firstName,lastName,mobile,profileImage;
 String country_id,addressDetails,zipcode,countryName;
 String passport,expiry;
 String birthPlace;
  String _selectCountry,selectCountry;
  bool _isLoading = false;
  var formattedDate;
  StateSetter set,setter, setterCountory,mySetter;
  DateTime selectedDate = DateTime.now();
 GlobalKey<FormState> key = new GlobalKey();
 GlobalKey<FormState> addresskey = new GlobalKey();
 GlobalKey<FormState> identificationkey = new GlobalKey();
 GlobalKey<FormState> birthdaykey = new GlobalKey();
 APIService service =APIService();
  ProgressDialog pr;
  Future<ProfileModel> profileModel;
  TextEditingController _date = new TextEditingController();
  TextEditingController _dateBirth = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState(); 
    getCountry();
  }


   
  final picker = ImagePicker();
  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getGallaryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                    primary: Color.fromRGBO(170, 131, 108, 1),
                                       ),
                
              ),
              child: child,
            );
          },
        lastDate: DateTime(2100));
       
        formattedDate = "${picked.year}-${picked.month}-${picked.day}";
    if (picked != null && picked != selectedDate)
     {setState(() {
        selectedDate = picked;
        print(selectedDate);
        _date.value = TextEditingValue(text: formattedDate.toString());
      });}
      else{
       print("click outside of datepicker");
      }
  }
  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                    primary: Color.fromRGBO(170, 131, 108, 1),
                                       ),
                
              ),
              child: child,
            );
          },
        lastDate: DateTime(2100));
    
        formattedDate = "${picked.year}-${picked.month}-${picked.day}";
         
    if (picked != null && picked != selectedDate)
     {setState(() {
        selectedDate = picked;
        print(selectedDate);
        _dateBirth.value = TextEditingValue(text: formattedDate.toString());
 
      });}
      else{
       print(" click outside of datepicker");
      }
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
    final String url = "http://dev.swiftassets.net/public/api/post_profile";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // var request = http.MultipartRequest
    Map<String, String> headers= {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['first_name'] = firstName.toString();
    request.fields['last_name'] = lastName.toString();
    request.fields['mobile'] = mobile.toString();
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("profile_image", _image.path);
    //add multipart to request
    request.files.add(pic);
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
          context, MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
    }
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

   addressUpload() async {
    setState(() {
      pr.show();
    });
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    //create multipart request for POST or PATCH method
    final String url = "http://dev.swiftassets.net/public/api/update_address";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // var request = http.MultipartRequest
    Map<String, String> headers= {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['zipcode'] = zipcode.toString();
    request.fields['address'] = addressDetails.toString();
    request.fields['city'] = country_id.toString();
    request.fields['country_id'] = _selectCountry.toString();
    
    print(request);
    var response = await request.send();
    print(response);
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
        context, MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }
  identificationUpload() async {
    setState(() {
      pr.show();
    });
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    //create multipart request for POST or PATCH method
    final String url = "http://dev.swiftassets.net/public/api/update_passport";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // var request = http.MultipartRequest
    Map<String, String> headers= {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['passport_expire'] = formattedDate.toString();
    request.fields['passport_no'] = passport.toString();
    print(request);
    var response = await request.send();
    print(response);
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
        context, MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

   birthdayUpload() async {
    setState(() {
      pr.show();
    });
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    //create multipart request for POST or PATCH method
    final String url = "http://dev.swiftassets.net/public/api/update_birthday";
    var request = http.MultipartRequest("POST", Uri.parse(url,),);
    // var request = http.MultipartRequest
    Map<String, String> headers= {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };

    request.headers.addAll(headers);
    request.fields['dob'] = formattedDate.toString();
    request.fields['country_of_birth'] = selectCountry.toString();
    request.fields['birth_place'] = birthPlace.toString(); 
    print(request);
    var response = await request.send();
    print(response);
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
        context, MaterialPageRoute(builder: (context) => BottomNavigationBarPage()));
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }





  Future<ProfileModel> getCountry() async {
     try {
           SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    final url = "http://dev.swiftassets.net/public/api/user";
   
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': '$header',
    }
    );
    print(response);
    if (response.statusCode == 200) {
      final getProduct = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      statesList = getProduct['data']['countries'];
       print("data .........................$statesList");
      
      return ProfileModel.fromJson(getProduct);
    } else {
     
    }
      } catch (e) {
        print("catch error");
      }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    
    return Scaffold(
        backgroundColor: Color.fromRGBO(170, 131, 108, 1),
        body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(105, 111, 119, 1),
                      Color.fromRGBO(170, 131, 108, 1)
                    ])),
            child: FutureBuilder<ProfileModel>(
                 future: service.getProfile(),
              builder: ( context, snapshot){
                if(snapshot.hasData){
                   url = snapshot.data.data.myReferalUrl.toString();
                  return ListView(
                  children: <Widget>[ 
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      title: Text("Profile",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      centerTitle: true,
                    ),
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height-100,
                        child: Stack(
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
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Container(
            height: 140,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: new Card(
                color: Colors.white,
                elevation: 6.0,
                margin: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 100,
                      width: 80,
                                 child:
                                         FadeInImage.assetNetwork(
                        placeholder: "assets/images/11594609873.jpg",
                        image: snapshot.data.data.image,
                      )
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 120,
                      width: 1,
                      color: Colors.grey,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 70,
                            width: 229,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    snapshot.data.data.firstName.toString() ==
                                        null ? Text("") : Text(
                                      snapshot.data.data.firstName.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    snapshot.data.data.lastName.toString() ==
                                        null ? Text("") :
                                    Text(snapshot.data.data.lastName.toString(),overflow: TextOverflow.ellipsis,
                                  
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    getEditProfile(context);
                                  },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0,left:8),
                                      child: Icon(Icons.edit),
                                    )),
                              ],
                            )),
                        Row(
                                             children: [
                                               Text("Email: "),
                                               SizedBox(
                                               width: 180.0,
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
                            snapshot.data.data.mobile.toString() == null ? Text(
                                "") : Text(snapshot.data.data.mobile
                                .toString(),overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Sponser: "),
                            snapshot.data.data.referral.toString() == null
                                ? Text("")
                                : Text(snapshot.data.data.referral.toString(),overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ],
                    )
                  ],
                )
            ),
          ),),
                            Positioned(
                              top: 140,
                              left: 0,
                              right: 0,
                              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 6.0, right: 6, top: 10, bottom: 5),
                child: Card(
                  color: Colors.white,
                  elevation: 8.0,
                  child: Container(
                    // margin  : EdgeInsets.only(bottom: 10),
                    height: 80,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Row(
                            children: [
                              Text("Your Corporate: ", style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold
                              ),),
                              snapshot.data.data.sourceOfSignup.toString() ==
                                  null ? Text("") :
                              Text(snapshot.data.data.sourceOfSignup.toString(),overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 6.0, right: 6, top: 0, bottom: 10),
                child: Card(
                  color: Colors.white,
                  elevation: 8.0,

                  child: Container(
                    // margin  : EdgeInsets.only(bottom: 10),
                    height: 120,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Text("Direct Share Your URL", style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 10),
                          initialValue: url,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 10),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.orange),
                              ),
                              border: UnderlineInputBorder(),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    FlutterClipboard.copy(url).then((
                                        result) {
                                      final snackBar = SnackBar(
                                        content: Text(url),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {},
                                        ),
                                      );
                                      Scaffold.of(context).showSnackBar(
                                          snackBar);
                                    });
                                  },
                                  child: Text("copy", style: TextStyle(
                                      color: Colors.black, fontSize: 15),))
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 7.0,),
              new Container(
                margin: EdgeInsets.only(top: 0, bottom: 10),
                height: 150,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: new Card(
                    color: Colors.white,
                    elevation: 8.0,
                    margin: EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 20),
                                child: Text(
                                  "Birthday Information", style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                              Row(
                                children: [
                                  Text("Date of Birth: "),
                                  snapshot.data.data.dob.toString() == null
                                      ? Text("")
                                      :
                                  Text(snapshot.data.data.dob.toString())
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text("Country: "),
                                  snapshot.data.data.countryBirthName
                                      .toString() == null ? Text("") :
                                  Text(snapshot.data.data.countryBirthName
                                      .toString(),overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text("Place: "),
                                  snapshot.data.data.birthPlace.toString() ==
                                      null ? Text("") :
                                  Text(
                                      snapshot.data.data.birthPlace.toString().replaceAll("00:00:00.000", ""),overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 7.0,),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: new IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                birthday(context);
                                print('Login Pressed');
                              },
                              color: Colors.black,
                          
                            ),
                          ),
                        ),

                      ],
                    )
                ),
              ),
            ],
          ),
                            ),
                          ],
                        )),
                   Container(
            height: 500,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 10.0,),
                new Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 160,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: new Card(
                      color: Colors.white,
                      elevation: 8.0,
                      margin: EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 20),
                                  child: Text("Address", style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                Row(
                                  children: [
                                    Text("Country: "),
                                   
                                    snapshot.data.data.addressCountryName
                                        .toString() == null ? Text("") :
                                    Text(snapshot.data.data.addressCountryName
                                        .toString()),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text("City: "),
                                    snapshot.data.data.city.toString() == null
                                        ? Text("")
                                        :
                                    Text(snapshot.data.data.city.toString(),overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text("Zip: "),
                                    snapshot.data.data.zipcode.toString() ==
                                        null ? Text("") :
                                    Text(snapshot.data.data.zipcode.toString(),overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                             children: [
                                               Text("Address: "), 
                                               SizedBox(
                                               width: 180.0,
                                               child:  snapshot.data.data.address.toString() != null?
                                               Text(snapshot.data.data.address.toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                              ):Text(""),
                                               ),
                                            
                                             ],
                                                ),
                              ],
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: 70.0,left: 130 ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: new IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    address(context);
                                    //productDetails(context);
                                    print('Login Pressed');
                                  },
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  height: 130,
                  color: Colors.white,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: new Card(
                      color: Colors.white,
                      elevation: 8.0,
                      margin: EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 20),
                                  child: Text(
                                    "Identification", style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                Row(
                                  children: [
                                    Text("Passport/Id: "),
                                    snapshot.data.data.passportNo.toString() ==
                                        null ? Text("") :
                                    Text(snapshot.data.data.passportNo
                                        .toString(),overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text("Card Expiry Date: "),
                                    snapshot.data.data.passportExpire
                                        .toString() == null ? Text("") :
                                    Text(snapshot.data.data.passportExpire
                                        .toString())
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: new IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  identification(context);
                                  print('Login Pressed');
                                },
                                color: Colors.black,
                                                            ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(height: 7.0,),
                Container(
                  height: 150,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0,),
                    child: Card(
                      elevation: 8,
                      child: Container(
                          height: 110,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 20),
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
                  ),
                ),

              ],
            ),
          ),

                  ]);
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
                 
            )
        ));
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

  List statesList;
  String _myState;
  birthday(BuildContext context) {
    // set up the buttons
    Widget submitButton = Container(
      margin: EdgeInsets.symmetric(horizontal: 95),
      child: FlatButton(
          color: Color.fromRGBO(170, 131, 108, 1),
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
             final loginForm = birthdaykey.currentState;
                        if (loginForm.validate()) {
                          loginForm.save();
                          birthdayUpload();
                        } else {
                          print("rrrrrrr");
                        }

          }
      ),
    );
    // show the dialog
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
                        "Birthday Information",
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
              content: StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                return Form(
              key: birthdaykey,
                child: ListView(
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: ()=> selectDate(context),
                      child: Container(
                          padding: EdgeInsets.only(top: 5),
                          height: 40.0,
                          width: 180.0,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _dateBirth,
                              keyboardType: TextInputType.datetime,
                             // onSaved: (val) => _quantity = val,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      )),
                                  labelText: "D.O.B",
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                        padding: EdgeInsets.only(top: 5),
                        height: 40.0,
                        width: 180.0,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (val) => birthPlace = val,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  )),
                              labelText: "Place Of Birth",
                              labelStyle: TextStyle(color: Colors.grey)),
                        )
                    ),
                    SizedBox(height: 10,),
                     Container(
                        margin: EdgeInsets.only(
                            left: 1.0,
                            right: 1.0,
                            bottom: 5.0),
                        padding: EdgeInsets.only(
                            left: 15.0,
                            top: 2.0,
                            right: 15.0, 
                            bottom: 2.0),
                        height: 40.0,
                        width: 220,
                        child:DropdownButton<String>(
                          value: selectCountry,
                          items: statesList?.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['name']),
                              value: item['id'].toString(),
                            );
                          })?.toList() ??
                              [],
                          hint: Text('Select Country'),
                          onChanged: (String newValue) {
                            setState(() {
                              selectCountry = newValue;
                              getCountry();

                              print(selectCountry);
                            });
                          },
                          isExpanded: true,
                          iconEnabledColor:
                          Color.fromRGBO(170, 131, 108, 1),
                          underline: Container(
                            height: 1.0,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.transparent,
                                        width: 0.0))),
                          ),
                        ),
                        decoration: BoxDecoration(

                            color: Color.fromRGBO(255, 255, 255, 1),
                            border: Border(
                                left: BorderSide(
                                  width: 5.0,
                                  color: Color.fromRGBO(170, 131, 108, 1),
                                )),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.2))
                            ])),

                    
                     
                  ],
                ),
              );
              },),
              actions: [
                submitButton,
              ],
            );
          },
        );
  }
  address(BuildContext context) {
    // set up the buttons
    Widget submitButton = Container(
      margin: EdgeInsets.symmetric(horizontal: 95),
      child: FlatButton(
          color: Color.fromRGBO(170, 131, 108, 1),
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
             final loginForm = addresskey.currentState;
                        if (loginForm.validate()) {
                          loginForm.save();
                          addressUpload();
                        } else {
                          print("rrrrrrr");
                        }

          }
      ),
    );
// show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
              title: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  height: 40.0,
                  color:Color.fromRGBO(170, 131, 108, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Address Information",
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
              content: StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                return Form(
                 key: addresskey,
                child: ListView(
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 5),
                        height: 40.0,
                        width: 180.0,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (val) => addressDetails = val,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  )),
                              labelText: "Address",
                              labelStyle: TextStyle(color: Colors.grey)),
                        )
                    ),
                    SizedBox(height: 5,),
                    Container(
                        padding: EdgeInsets.only(top: 5),
                        height: 40.0,
                        width: 180.0,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (val) => country_id = val,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  )),
                              labelText: "City",
                              labelStyle: TextStyle(color: Colors.grey)),
                        )
                    ),
                    SizedBox(height: 5,),
                    Container(
                        padding: EdgeInsets.only(top: 5),
                        height: 40.0,
                        width: 180.0,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (val) => zipcode = val,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  )),
                              labelText: "ZipCode",
                              labelStyle: TextStyle(color: Colors.grey)),
                        )
                    ),
                    SizedBox(height: 10,),
                    Container(
                        margin: EdgeInsets.only(
                            left: 1.0,
                            right: 1.0,
                            bottom: 5.0),
                        padding: EdgeInsets.only(
                            left: 15.0,
                            top: 2.0,
                            right: 15.0,
                            bottom: 2.0),
                        height: 40.0,
                        width: 220,
                        child:DropdownButton<String>(
                          value: _selectCountry,
                          items: statesList?.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['name']),
                              value: item['id'].toString(),
                            );
                          })?.toList() ??
                              [],
                          hint: Text('Select Country'),
                          onChanged: (String newValue) {
                            setState(() {
                              _selectCountry = newValue;
                              getCountry();

                              print(_selectCountry);
                            });
                          },
                          isExpanded: true,
                          iconEnabledColor:
                          Color.fromRGBO(170, 131, 108, 1),
                          underline: Container(
                            height: 1.0,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.transparent,
                                        width: 0.0))),
                          ),
                        ),
                        decoration: BoxDecoration(

                            color: Color.fromRGBO(255, 255, 255, 1),
                            border: Border(
                                left: BorderSide(
                                  width: 5.0,
                                  color: Color.fromRGBO(170, 131, 108, 1),
                                )),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.2))
                            ])),


                  ],
                ),
              );
              },),
              actions: [
                submitButton,
              ],
            );
      },
    );
  }

  identification(BuildContext context) {
    // set up the buttons
    Widget submitButton = Container(
      margin: EdgeInsets.symmetric(horizontal: 95),
      child: FlatButton(
          color: Color.fromRGBO(170, 131, 108, 1),
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
             final loginForm = identificationkey.currentState;
                        if (loginForm.validate()) {
                          loginForm.save();
                          identificationUpload();
                        } else {
                          print("rrrrrrr");
                        }

          }
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              padding: EdgeInsets.only(left: 10.0),
              height: 40.0,
              color:Color.fromRGBO(170, 131, 108, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Identification",
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
          content: StatefulBuilder(builder: (BuildContext context,StateSetter setState ){
            return Form(
             key: identificationkey,
            child: ListView(
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 5),
                    height: 40.0,
                    width: 180.0,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (val) => passport = val,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              )),
                          labelText: "Passport/ID Card Number",
                          labelStyle: TextStyle(color: Colors.grey)),
                    )),
                               SizedBox(height: 20,),
              
                GestureDetector(
      onTap: (){
         _selectDate(context);
      },
          child: Container(
             padding: EdgeInsets.only(top: 5),
                           height: 40.0,
                          width: 180.0,
            child: AbsorbPointer(
                          child: TextFormField(
                 style: TextStyle(color: Colors.black),
                 controller: _date,
             onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.next,
            obscureText: false,
            keyboardType: TextInputType.datetime,
           decoration: InputDecoration(
            border: OutlineInputBorder(
           borderSide: BorderSide(
           color: Colors.green,
                  )),
          labelText: "Passport/ID Card Expiry Date",
          labelStyle: TextStyle(color: Colors.grey)),
                            ),
                          )
                      ),
        ),
            
          
    
    

              ],
            ),
          );
          },),
          actions: [
            submitButton,
          ],
        );
          }
        );
      
    
  }
  getEditProfile(BuildContext context) {
    // set up the buttons
    Widget submitButton = Container(
      margin: EdgeInsets.symmetric(horizontal: 95),
      child: FlatButton(
          color: Color.fromRGBO(170, 131, 108, 1),
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
             final loginForm = key.currentState;

                        if (loginForm.validate()) {
                          loginForm.save();
                          _asyncFileUpload();
                        } else {
                          print("rrrrrrr");
                        }
          }

      ));
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              setter = setState;
              return AlertDialog(
                title: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: 40.0,
                    color:Color.fromRGBO(170, 131, 108, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Personal Details",
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
                content: Form(
                  key: key,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          height: 40.0,
                          width: 180.0,
                          child: TextFormField(
                           // controller: firstNameController,
                            keyboardType: TextInputType.text,
                            onSaved: (val) => firstName = val,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    )),
                                labelText: "First Name",
                                labelStyle: TextStyle(color: Colors.grey)),
                          )

                      ),
                      SizedBox(height: 10,),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          height: 40.0,
                          width: 180.0,
                          child: TextFormField(
                            //controller: lastNameController,
                            keyboardType: TextInputType.text,
                            onSaved: (val) => lastName = val,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    )),
                                labelText: "Last Name",
                                labelStyle: TextStyle(color: Colors.grey)),
                          )),
                      SizedBox(height: 10,),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          height: 40.0,
                          width: 180.0,
                          child: TextFormField(
                           keyboardType: TextInputType.number,
                            onSaved: (val) => mobile = val,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            maxLength: 10,
                            decoration: InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    )),
                                labelText: "Mobile",
                                labelStyle: TextStyle(color: Colors.grey)),
                          )

                      ),
                      SizedBox(height: 10,),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          height: 100.0,
                          width: 180.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Profile Picture",style: TextStyle(color: Colors.grey),),
                              SizedBox(height: 5,),
                              RaisedButton(
                                onPressed: (){
                                  _showSelectionDialog(context);
                                },
                                color: Colors.grey,
                                child: Text("Choose File",style: TextStyle(color: Colors.black),),
                              ),
                              _image.toString() == null? Text("no choosen file ",style: TextStyle(fontSize: 8),): Text(_image.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(

                              ),),
                            ],
                          ))
                    ],
                  ),
                ),
                actions: [
                  submitButton,
                ],
              );
            }
        );
      },
    );
  }
  Future<void> _showSelectionDialog(BuildContext context) {
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
                        getGallaryImage();
                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        getCameraImage();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
}


