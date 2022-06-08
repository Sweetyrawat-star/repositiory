import 'package:flutter/material.dart';

class ResourcePage extends StatefulWidget {
  @override
  _ResourcePageState createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
 

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
                    title: Text(
                      "Resource",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                            height: 120,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  DataTable(
                                    columns: [
                                      DataColumn(label: Text('S.No')),
                                      DataColumn(label: Text('Name')),
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
}