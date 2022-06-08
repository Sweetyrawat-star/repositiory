import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftasset/model/getNodes.dart';
import 'package:swiftasset/sharedpreference/store.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebsitePage extends StatefulWidget {
  @override
  _WebsitePageState createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> {
  bool _isLoading=true;
  String webUrl;
  var url;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    url;
    getNode();
 
  }

  Future<Getnodes> getNode() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      print("token" + "$store1");
      var header = "Bearer $store1";
      final url = "http://dev.swiftassets.net/public/api/nodes";

      final response = await http.get(url, headers: {
        //"Content-Type": "application/json",
        'Authorization': '$header',
      }
      );
      print(response);
      if (response.statusCode == 200) {
        final getProduct = jsonDecode(response.body);
        print(response.statusCode);
        print(response. body);
        return Getnodes.fromJson(getProduct);
      } else {

      }

    } catch (e) {
      print("catch error");
    }
    return Getnodes();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          toolbarHeight: kToolbarHeight,
          automaticallyImplyLeading: true,
          title: Text("Network ",style: TextStyle(color: Colors.white),),
          leading: GestureDetector(onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back)),
          backgroundColor:Color.fromRGBO(170, 131, 108, 1),
          //Color.fromRGBO(3, 78, 146, 1),


        ),
        body: FutureBuilder(
          future: getNode(),
          builder: (BuildContext context, AsyncSnapshot<Getnodes>snapshot){
            url = snapshot.data.data.toString();
          if(snapshot.hasData){
            return ProgressHUD(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: <Widget>[
                  WebView(
                    initialUrl: snapshot.data.data,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: pageFinishedLoading,
   
                  onWebViewCreated: (WebViewController webViewController) {
  	            _controller.complete(webViewController);
                   },

                  ),
                ],
              ),
            ),
            inAsyncCall: _isLoading,
            opacity: 0.0,
          );
          }else{
            return Center(
              child: CircularProgressIndicator()
            );
          }
        },));
  }

  void pageFinishedLoading(String url) {
    setState(() {
      _isLoading = false;
    });
  }
}

getUrl(){
  return FutureBuilder(
    builder: (BuildContext context,AsyncSnapshot<Getnodes>snapshot){
      String web = snapshot.data.data;
      return Text(snapshot.data.data);
    },
  );
}

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  ProgressHUD({
    Key key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          new Center(
            child: new CircularProgressIndicator(
              valueColor: valueColor,
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}