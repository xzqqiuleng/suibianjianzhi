import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/login_pd_page.dart';
import 'package:recruit_app/pages/mine/feedback.dart';
import 'package:recruit_app/pages/mine/push_set.dart';
import 'package:recruit_app/pages/mine/send_resume.dart';
import 'package:recruit_app/pages/msg/agreement.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'comunicate.dart';
import 'mine_infor.dart';
import 'mine_jl.dart';
import 'package:recruit_app/model/me_list.dart';
import 'package:recruit_app/pages/setting/new_setting.dart';

class MeJz extends StatefulWidget {
  @override
  _MeJzState createState() => _MeJzState();
}


class _MeJzState extends State<MeJz> {
  List<Me> options = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    options.add( Me(imgPath: 'images/me1.png', itemName: '推送设置', itemStatus: ''));
    options.add( Me(imgPath: 'images/me2.png', itemName: '意见反馈', itemStatus: ''));
    options.add( Me(imgPath: 'images/me3.png', itemName: '好评一下', itemStatus: ''));
    options.add( Me(imgPath: 'images/me4.png', itemName: '隐私与协议', itemStatus: ''));
    options.add( Me(imgPath: 'images/me5.png', itemName: '设置', itemStatus: ''));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/img_setting_white.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting(), ),);
              }),
        ],
        backgroundColor: Colours.app_main,
      ),
      body: SingleChildScrollView(

        child: Column(
          children: <Widget>[
            Container(
              height: 260,
              child:Stack(
                  children: [
                    Container(
                      height: 200,
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(48),
                          right: ScreenUtil().setWidth(48),
                          bottom: ScreenUtil().setWidth(48),
                          top: ScreenUtil().setWidth(20)),
                      color:  Colours.app_main,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              if(ShareHelper.isLogin()){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>MineInfor(),),);
                              }else{
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPdPage(),),);
                              }

                            },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                Expanded(
                                  child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:<Widget>[
                                      Text(
                                        '哈哈哈哈哈登',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(40),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setWidth(20),
                                      ),
                                      Text(
                                        '点击登录',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(30),
                                        ),
                                      ),

                                    ],

                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(70),
                                  ),
                                  child: Image.asset(
                                    'images/img_icon_harden.png',
                                    width: ScreenUtil().setWidth(140),
                                    height: ScreenUtil().setWidth(140),
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              ],
                            ),
                          ),

                          SizedBox(
                            height: ScreenUtil().setWidth(76),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '18',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(36),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '已投递',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Color.fromRGBO(227, 226, 226, 1),
                                          fontSize: ScreenUtil().setSp(24),
                                        ),
                                      ),

                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>SendResumeJob(),),);

                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(10),
                                ),
                                width: ScreenUtil().setWidth(1),
                                height: ScreenUtil().setHeight(28),
                                color: Colors.white,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '18',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(36),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '待面试',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Color.fromRGBO(227, 226, 226, 1),
                                          fontSize: ScreenUtil().setSp(24),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(10),
                                ),
                                width: ScreenUtil().setWidth(1),
                                height: ScreenUtil().setHeight(28),
                                color: Colors.white,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        '18',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(36),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '沟通过',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Color.fromRGBO(227, 226, 226, 1),
                                          fontSize: ScreenUtil().setSp(24),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>ComunicateJob(),),);
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 14,
                      right: 14,
                      child: GestureDetector(

                        onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>MineJL(),),);
                    },
                      child:Card(
                        elevation: 0.2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child:  Text(
                                  "   优秀的简历，精准的推荐",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      wordSpacing: 2,
                                      fontWeight: FontWeight.w100
                                  ),
                                )
                            ),
                            Container(
                              height: 30,
                              width: 70,
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(16,20,14,20),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Text(
                                "编辑简历",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      )
                    )
                  ],

              ),
            ),

////           Row(
//             children: <Widget>[
//               SizedBox(width: 16,),
//               Container(
//                 width: 2,
//                 height: 16,
//                 color: Colours.app_main,
//               ),
//               Text(
//                 "收藏与关注"
//               )
//             ],
//           ),
            SizedBox(height: 16,),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 16,),
                      Image.asset("images/love.png",height: 40,width: 40),
                      SizedBox(width: 16,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "兼职收藏",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                              "你感兴趣的兼职",style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w100
                          ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 16,),
                      Image.asset("images/sub.png",height: 40,width: 40),
                      SizedBox(width: 16,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "公司关注",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "公司职位不遗漏",style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.w100
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
             SizedBox(
               height: 16,
             ),
             ListView.builder(itemBuilder: (BuildContext context,int index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(48),
                              vertical: ScreenUtil().setWidth(40),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  options[index].imgPath,
                                  width: ScreenUtil().setWidth(40),
                                  height: ScreenUtil().setWidth(40),
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(20),
                                ),
                                Expanded(
                                  child: Text(
                                    options[index].itemName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Color.fromRGBO(57, 57, 57, 1),
                                        fontSize: ScreenUtil().setSp(32)),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(20),
                                ),
                                Text(
                                  options[index].itemStatus,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Color.fromRGBO(194, 203, 202, 1),
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(20),
                                ),
                                Image.asset(
                                  'images/img_arrow_right_blue.png',
                                  width: ScreenUtil().setWidth(10),
                                  height: ScreenUtil().setWidth(20),
                                  fit: BoxFit.cover,
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            if (index == 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PushSetPage()));
                            } else if (index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeedbackPage()));
                            } else if (index == 2) {

                            }else if(index == 3){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AgreementPage()));
                            }else if(index == 4){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewSetting()));
                            }
                          },
                        ),
                    Container(
                      color: Color(0xfff8f8f8),
                      height: 1,
                    )
                  ],
                );
             },
             itemCount: options.length,
               physics: const NeverScrollableScrollPhysics(),
               shrinkWrap: true,
             )
          ],
        ),
      )

    );
  }
}
