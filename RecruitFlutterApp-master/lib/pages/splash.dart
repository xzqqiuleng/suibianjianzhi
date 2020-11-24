import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/jzjxpage.dart';
import 'package:recruit_app/pages/mj/mj_constant.dart';
import 'package:recruit_app/pages/mj/mj_web.dart';
import 'package:recruit_app/pages/mj/mjbean.dart';
import 'package:recruit_app/pages/provider/app_update.dart';

//class Splash extends StatelessWidget {
//
//
//  void _autoTurn(BuildContext context){
//    Future.delayed(Duration(seconds: 1), (){
//      Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(
//            builder: (context) => RecruitHomeApp(),
//          ));
//
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ScreenUtil.init(context, width: 750, height: 1334);
//    _autoTurn(context);
//    return Scaffold(
//        body:Image.asset("images/timg.jpg",width: 20,height: 20,)
//
//    );
//  }
//}
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
 String imgUrl="images/timg.jpg";
// String imgUrl = "images/qg.png";
 String goType="";
 String murl="";
 bool isShow= true;
 bool isURl = false;

 bool noTurn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      getState();

  }
  getState(){
    new Dio().post('http://116.62.45.24/api/appConfig/get', queryParameters: {
      'app_id': "bbc8ea5cea6c4078b7dba74b80bf5c12",
    }).then((value){
        var jsroStr =  json.decode(value.toString());
        var result = MjBean.fromJson(jsroStr["result"]);
            if(result.status == "1"){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MJWeb(result.webUrl)));

            }else if(result.status == "2"){
              setState(() {
                imgUrl = "images/qg.png";
              });
              downloadUrlApp(context,result.forceUpdateUrl);
            }else{
              if(result.adStatus == "1"){
                MjConstant.ad_img_url = result.adImgUrl;
                MjConstant.ad_go_type = result.adGoType;
                MjConstant.ad_url = result.adUrl;
              }
                if(result.startAdStatus == "1"){
                  delay();
                  setState(() {
                    isURl = true;
                    imgUrl = result.startAdImgUrl;
                    goType = result.startAdGoType;
                    murl = result.startAdUrl;
                    isShow = false;
                  });
                }else{
                   goMain();
                }


            }
          return result;
    });

  }
 int indes = 5;
 delay(){
   Future.delayed(Duration(seconds: 1), (){
     if(indes == 1){
       if(!noTurn ){
         goMain();
       }

     }else{
       setState(() {
         indes--;
       });
       delay();
     }
   });
 }
 goMain(){
   Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RecruitHomeApp()));
 }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
//    return Scaffold(
//
//        body:imgUrl.startsWith("iamges/")?Image.asset(imgUrl,width: 750,height: 1334,):Image.network(imgUrl,width: 750,height: 1334,)
//
//    );
     return Scaffold(
        body:  Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: (){
                          if(murl == ""){
                            return;
                          }
                          if(goType == "2"){
                            noTurn = true;
                            downloadUrlApp(context,murl);

                          }else if(goType == "1"){
                            noTurn = true;
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MJWeb(murl)));

                          }
                        },
                        child: !isURl?Image.asset(imgUrl,fit: BoxFit.fill,):Image.network(imgUrl,fit: BoxFit.fill,)
                      )
                  ),

                  Positioned(
                    top: 30,
                    right: 16,
                    child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){ goMain();},
                        child:Offstage(
                          offstage: isShow,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10,4,10,4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black12
                            ),
                            child: Text(
                              "${indes}s |  跳过",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )
                    ),
                  )
                ],

              )

    );
  }
}
