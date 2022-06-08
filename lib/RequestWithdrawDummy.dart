import 'package:flutter/material.dart';

class RequestWithdrawPage extends StatefulWidget {
  @override
  _RequestWithdrawPageState createState() => _RequestWithdrawPageState();
}

class _RequestWithdrawPageState extends State<RequestWithdrawPage> {
String _quantity;
 String _brandDropdownValue;
  

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
                    colors: [Color.fromRGBO(105, 111, 119,1),Color.fromRGBO(170, 131, 108,1)])),
        child: Stack(
          children: <Widget>[
            new Image.asset(
              'assets/images/b-c2.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              // --> App Bar
              child: Column(
                children: <Widget>[
                  AppBar(
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    // leading: Icon(Icons.arrow_back),
                    title: Text(
                      "List",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                     Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                            child: Center(
                              child:  new RaisedButton(
                  onPressed: () {
                    productDetails(context);
                    print('Login Pressed');
                  },
                  color: Colors.orange,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: new Text('Request Withdraw',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
                            ),
                          ),
                  ),
                ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 210,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                          child: ListView(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Withdraw Request",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        
                          Container(
                            height: 120,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  DataTable(
                                    columns: [
                                      DataColumn(label: Text('Amount')),
                                      DataColumn(label: Text('Description')),
                                      DataColumn(label: Text('Status')),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text('No Record Found')),
                                         DataCell(Text('No Record Found')),
                                          DataCell(Text('No Record Found')),
                                        
                                      ]),
                                      // DataRow(cells: [
                                      //   DataCell(Text('Raj Kapoor')),
                                      //   DataCell(Text('raj100')),
                                      //   DataCell(Text('Manoj.sharma@gmail.com')),
                                      // ]),
                                      // DataRow(cells: [
                                      //   DataCell(Text('Sourabh Singh')),
                                      //   DataCell(Text('Saurabh.1')),
                                      //   DataCell(Text('Manoj.sharma@gmail.com')),
                                      // ]),
                                    ],
                                  ),
                                ]),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Showing 1 to 3 of 3 entries",
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 230),
                    child: Row(
                      children: [
                        Text("Previous",style: TextStyle(color: Colors.white),),
                         Container(
                           margin: EdgeInsets.all(5),
                           width: 20,
                           color: Colors.white,
                           child: Center(child: Text("1"))),
                          Text("Next",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
     
    );
  }
    productDetails(BuildContext context) {
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
        
          } 
      ),
    );

    // set up the AlertDialog
  
        AlertDialog alert = AlertDialog(
          title: Container(
              padding: EdgeInsets.only(left: 10.0),
              height: 40.0,
              color:Color.fromRGBO(170, 131, 108, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Request Withdraw",
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
            // key: _loginFormKey,
            child: ListView(
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                                    // width: 220,
                                    child: DropdownButton<String>(
                                      value: _brandDropdownValue,
                                      items: <String>['1', '1']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1))),
                                        );
                                      }).toList(),
                                      hint: Text('Select Via'),
                                      onChanged: (String value) {
                                        setState(() {
                                          _brandDropdownValue = value;
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
                                        Container(
                   
                                    margin: EdgeInsets.only(
                                        left: 1.0,
                                        top: 5.0,
                                        right: 1.0,
                                        bottom: 5.0),
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        top: 2.0,
                                        right: 15.0,
                                        bottom: 2.0),
                                    height: 40.0,
                                    // width: 220,
                                    child: DropdownButton<String>(
                                      value: _brandDropdownValue,
                                      items: <String>['1', '1']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1))),
                                        );
                                      }).toList(),
                                      hint: Text('Select Vault'),
                                      onChanged: (String value) {
                                        setState(() {
                                          _brandDropdownValue = value;
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
                Container(
                  padding: EdgeInsets.only(top: 5),
                    height: 40.0,
                    width: 180.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (val) => _quantity = val,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      )),
                      labelText: "Amount",
                      labelStyle: TextStyle(color: Colors.grey)),
                )
                
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                    height: 40.0,
                    width: 180.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (val) => _quantity = val,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      )),
                      labelText: "Transaction Password",
                      labelStyle: TextStyle(color: Colors.grey)),
                )
                
                ),
                 
          ],
        ),
      ),
      actions: [
        submitButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(),
          child: alert,
        );
      },
    );
  }
}