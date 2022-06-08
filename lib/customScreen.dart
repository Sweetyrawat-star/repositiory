import 'package:flutter/material.dart';
import 'package:swiftasset/BottomNavigatiobar.dart';
import 'package:swiftasset/Profile.dart';

class CustomCard {

  static buildButton({BuildContext context }){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 140,
          width: MediaQuery.of(context).size.width,
          child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildButtonContainer(name: "Dashboard",
                            onTap: Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()))),
                        buildButtonContainer(name: "Profile",
                            onTap: Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()))),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildButtonContainer(name: "My Network",
                            onTap: Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()))),
                        buildButtonContainer(name: "LogOut",
                            onTap: Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()))),
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
  static  buildButtonContainer({String name,onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          color: Color(0xfffadbad),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: new Text(name,
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }



}
