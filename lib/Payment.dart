
import 'package:flutter/material.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/Profile.dart';
import 'package:swiftasset/api/api_service.dart';
import 'package:swiftasset/dashboardScreen.dart';
import 'package:swiftasset/model/Payment.dart';
import 'package:swiftasset/webview.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String token;
  bool isLoading = false;
  String bankAddress,
      bankName,
      bankSwiftCode,
      bankComment,
      bankAccountNumber,
      bankCountry,
      accountHolderName,
      bankWithdrawAmount;

  @override
  void initState() {
    super.initState();
    APIService.getPayment();
  }
  int selectedIndex = 0;
  
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
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Column(children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text(
                      "Payment",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                    // leading:Icon(Icons.arrow_back),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height,
                      child: FutureBuilder<PaymentModel>(
                      future: APIService.getPayment(),
                      builder: (context, snapshot) {
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
                              top: 20,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                child: ListView(
                                  children: [
                                    new Container(
                                      child: new Card(
                                        color: Colors.white,
                                        elevation: 8,
                                        margin: EdgeInsets.only(right: 10.0, left: 15.0,bottom: 10),
                                        child: new Wrap(
                                          children: <Widget>[
                                            Center(
                                              child: new Container(
                                                margin: EdgeInsets.only(top: 20.0),
                                                child: new Text(
                                                  'Bank Details',
                                                  style:
                                                  TextStyle(fontSize: 25.0, color: Colors.orange),
                                                ),
                                              ),
                                            ),
                                            new ListTile(
                                              title: new TextFormField(
                                                initialValue: accountHolderName == null
                                                    ? ""
                                                    : accountHolderName.toString(),
                                                decoration: new InputDecoration(
                                                  hintText: 'Account Holder Name',
                                                  labelText: 'Account Holder Name',
                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                              ),
                                            ),
                                            new ListTile(
                                              title: new TextFormField(
                                                initialValue: snapshot.data.data.bankWithdrawAmount
                                                    .toString() ==
                                                    null
                                                    ? "No data found"
                                                    : snapshot.data.data.bankWithdrawAmount.toString(),
                                                decoration: new InputDecoration(
                                                  hintText: 'Withdrawal Amount',
                                                  labelText: 'Withdrawal Amount',
                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                                
                                              ),
                                            ),
                                            new ListTile(
                                              title: new TextFormField(
                                                initialValue:
                                                snapshot.data.data.bankName.toString() == null
                                                    ? "No data found"
                                                    : snapshot.data.data.bankName.toString(),
                                                decoration: new InputDecoration(
                                                  hintText: 'Bank Name',
                                                  labelText: 'Bank Name',
                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                               
                                              ),
                                            ),
                                            new ListTile(
                                              title: new TextFormField(
                                                initialValue:
                                                snapshot.data.data.bankAddress.toString() == null
                                                    ? "No data found"
                                                    : snapshot.data.data.bankAddress.toString(),
                                                decoration: new InputDecoration(
                                                  hintText: 'Bank Address',
                                                  labelText: 'Bank Address',
                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                             
                                              ),
                                            ),
                                            new ListTile(
                                              title: new TextFormField(
                                                initialValue:
                                                snapshot.data.data.bankCountry.toString() == null
                                                    ? "No data found"
                                                    : snapshot.data.data.bankCountry.toString(),
                                                decoration: new InputDecoration(
                                                  hintText: 'Bank Country',
                                                  labelText: 'Bank Country',
                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                            
                                              ),
                                            ),
                                            new ListTile(
                                              title: new TextFormField(
                                                initialValue: snapshot.data.data.bankAccountNumber
                                                    .toString() ==
                                                    null
                                                    ? "No data found"
                                                    : snapshot.data.data.bankAccountNumber.toString(),
                                                decoration: new InputDecoration(
                                                  hintText: 'Bank Account Number',
                                                  labelText: 'Bank Account Number',
                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                               
                                              ),
                                            ),
                                            new ListTile(
                                              title: new TextFormField(
                                                initialValue: bankSwiftCode == null
                                                    ? "No data found"
                                                    : bankSwiftCode.toString(),
                                                decoration: new InputDecoration(
                                                  hintText: 'Bank Swift Code(BIC)',
                                                  labelText: 'Bank Swift Code(BIC)',
                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                              
                                              ),
                                            ),
                                            new ListTile(
                                              title: new TextFormField(
                                                initialValue:
                                                snapshot.data.data.bankComment.toString() == null
                                                    ? "No data found"
                                                    : snapshot.data.data.bankComment.toString(),
                                                decoration: new InputDecoration(
                                                  hintText: 'Additional Comment',
                                                  labelText: 'Additional Comment',
                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                              
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                                              child: Center(
                                                child: new RaisedButton(
                                                  onPressed: () {
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
                                            SizedBox(height: 30,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                        ),
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
                                    ),
                                    SizedBox(height: 100,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      }
                      ))
                ]),

              ])),
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
