import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:recruit_app/colours.dart';

class MJWeb extends StatelessWidget{
  String url;
 MJWeb(this.url);


  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
//        appBar: AppBar(
//          elevation: 0,
//          centerTitle: true,
//          title: Text("推广",
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
//              style: const TextStyle(
//                  wordSpacing: 1,
//                  letterSpacing: 1,
//                  fontSize: 16,
//                  fontWeight: FontWeight.bold,
//                  color: Color.fromRGBO(37, 38, 39, 1))),
//          leading: IconButton(
//              icon: Image.asset(
//                'images/ic_back_arrow.png',
//                width: 18,
//                height: 18,
//              ),
//              onPressed: () {
//                Navigator.pop(context);
//              }),
//          automaticallyImplyLeading: false,
//          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
//        ),
      body: WebviewScaffold(
          url: url)


    );

  }

}