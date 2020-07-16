import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:recruit_app/pages/jzjxpage.dart';

class Splash extends StatelessWidget {


  void _autoTurn(BuildContext context){
    Future.delayed(Duration(seconds: 1), (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => JZJXPage("1111"),
          ));

    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    _autoTurn(context);
    return Scaffold(
        body:Image.asset("images/iconc_hc.png",width: 20,height: 20,)

    );
  }
}
