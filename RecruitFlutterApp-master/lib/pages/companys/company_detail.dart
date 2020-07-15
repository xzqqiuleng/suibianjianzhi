import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/company_pic_list.dart';
import 'package:recruit_app/model/company_welfare_list.dart';
import 'package:recruit_app/model/job_list.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/companys/company_job.dart';
import 'package:recruit_app/pages/companys/company_job_item.dart';
import 'package:recruit_app/pages/companys/company_pic_item.dart';
import 'package:recruit_app/pages/companys/company_welfare_item.dart';
import 'package:recruit_app/pages/companys/gs_info.dart';
import 'package:recruit_app/pages/constant.dart';
import 'package:recruit_app/pages/jobs/job_detail.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/widgets/bottom_drawer_widget.dart';

class CompanyDetail extends StatefulWidget {
  int id;
  CompanyDetail(this.id);
  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
  List<CompanyPicData> _picList = CompanyPicList.loadCompanyPicList();
  Map infors ;
//  List<String> labels=["五险一金"];
  List<String>tip=["五险一金"];
  List datalist=List() ;
  List<Job> _jobList = JobData.loadJobs();
  Map com_label;
  Map compay_info;
  List<GSInfo> gsInfos=List();
  @override
  void initState() {
    super.initState();



    _loadData();
  }
  _loadData(){

    if(widget.id == null){
      widget.id = 8192;
    }
    new MiviceRepository().getCompanyDetail(widget.id).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        var   data = reponse["result"];


        setState(() {
          infors = data["com"];
        List  jobList = data["jobs"];
        datalist.clear();
          datalist.addAll(jobList);
          compay_info = json.decode(infors["company_info"].toString());

          if(infors["label"] !=null && infors["label"] != ""){
            com_label = json.decode(infors["label"].toString());
          }


          tip = data["tip"].toString().split(" ");

          _getContent();


        });

      }
    });
  }
  void _getContent(){
    gsInfos.clear();
    if(com_label == null){
      return;
    }
    com_label.forEach((key, value) {
 GSInfo gsInfo = GSInfo(key, value);
     gsInfos.add(gsInfo);
     });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/bg_wjd_share_init.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 30,
              sigmaX: 30,
            ),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.7),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          AppBar(
            leading: IconButton(
                icon: Image.asset(
                  'images/ic_action_back_white.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            automaticallyImplyLeading: false,
            centerTitle: true,
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: Colors.black87),
            backgroundColor: Colors.transparent,
            title: Text(
              '公司详情',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Image.asset(
                    'images/ic_action_settings.png',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {}),
            ],
          ),
          SafeArea(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: kToolbarHeight),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 18, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        elevation: 1,

                        child: Container(
                          height:160,
                          child: Stack(
                            children: <Widget>[
                               Positioned(
                                 left: 76,
                                 top: 22,
                                 right: 90,
                                 child:  Text( infors == null?"": infors["name"],
                                     maxLines: 2,
                                     overflow: TextOverflow.ellipsis,
                                     style: const TextStyle(
                                         wordSpacing: 1,
                                         letterSpacing: 1,
                                         fontSize: 16,
                                         fontWeight: FontWeight.bold,
                                         color: Colors.black87)),
                               ),
                              Positioned(
                                left: 16,
                                top: 20,
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  child: Image.network(
                                      infors == null|| infors["company_img"].toString() ==""?Constant.deault_compay:infors["company_img"],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                left: 76,
                                top: 70,
                                child:Row(
                                  children: <Widget>[

                                    Text(
                                      '企业认证',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(22),
                                        color: Color.fromRGBO(151, 151, 151,6),
                                      ),
                                    ),
                                  ],
                                )),
                              Positioned(
                                right: 4,
                                top: 4,
                                child: Image.asset('images/jz_rz.png',
                                    width: ScreenUtil().setWidth(94),
                                    height: ScreenUtil().setWidth(34),
                                    fit: BoxFit.cover),
                              ),
                              Positioned(
                                bottom: 20,
                                left:16,
                                right: 16,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff8f8f8),
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: tip.length,
                            itemBuilder: (context, index) {
                              if (index < tip.length) {
                                return CompanyWelfareItem(
                                  welfareData: tip[index],
                                  index: index,
                                  isLastItem: index == tip.length - 1,
                                );
                              }
                              return null;
                            }),
                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Expanded(
//                            child: Wrap(
//                                crossAxisAlignment: WrapCrossAlignment.center,
//                                spacing: 20,
//                                runSpacing: 10,
//                                children: <Widget>[
//                                  Text('上午10:00-下午07:00',
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)),
//                                  Text('双休',
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)),
//                                  Text('弹性工作',
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)),
//                                ]),
//                          ),
//                          SizedBox(
//                            width: 15,
//                          ),
//                          Text('更多福利',
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(
//                                  wordSpacing: 1,
//                                  letterSpacing: 1,
//                                  fontSize: 14,
//                                  color: Color.fromRGBO(181, 182, 183, 1))),
//                          SizedBox(
//                            width: 8,
//                          ),
//                          Image.asset(
//                            'images/f3_right_arrow_white.png',
//                            width: 10,
//                            height: 10,
//                            fit: BoxFit.cover,
//                          ),
//                        ],
//                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text('公司介绍',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 20,
                      ),
                    Html(data: compay_info== null?"":compay_info["公司信息"].replaceAll("微信分享", "").replaceAll("地图", "")),
                      SizedBox(
                        height: 20,
                      ),
//                      Text('公司照片',
//                          maxLines: 1,
//                          overflow: TextOverflow.ellipsis,
//                          style: const TextStyle(
//                              wordSpacing: 1,
//                              letterSpacing: 1,
//                              fontSize: 18,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.black87)),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Container(
//                        height: 150,
//                        child: ListView.builder(
//                            physics: BouncingScrollPhysics(),
//                            shrinkWrap: true,
//                            scrollDirection: Axis.horizontal,
//                            itemCount: _picList.length,
//                            itemBuilder: (context, index) {
//                              if (index < _picList.length) {
//                                return CompanyPicItem(
//                                  picData: _picList[index],
//                                  index: index,
//                                  isLastItem: index == _picList.length - 1,
//                                );
//                              }
//                              return null;
//                            }),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
                      Text('公司地址',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Image.asset('images/map_icon.jpg',
                            height: 100, fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: 20,
                      ),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text('公司还有9个其他办公地址',
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                                style: const TextStyle(
//                                    wordSpacing: 1,
//                                    letterSpacing: 1,
//                                    fontSize: 14,
//                                    color: Colors.white)),
//                          ),
//                          SizedBox(
//                            width: 15,
//                          ),
//                          Text('查看全部',
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                              style: const TextStyle(
//                                  wordSpacing: 1,
//                                  letterSpacing: 1,
//                                  fontSize: 14,
//                                  color: Color.fromRGBO(181, 182, 183, 1))),
//                        ],
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Text('公司官网',
//                          maxLines: 1,
//                          overflow: TextOverflow.ellipsis,
//                          style: const TextStyle(
//                              wordSpacing: 1,
//                              letterSpacing: 1,
//                              fontSize: 18,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.white)),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text('http://www.tencent.com',
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                                style: const TextStyle(
//                                    wordSpacing: 1,
//                                    letterSpacing: 1,
//                                    fontSize: 14,
//                                    color: Colors.white)),
//                          ),
//                          SizedBox(
//                            width: 15,
//                          ),
//                          Image.asset(
//                            'images/f3_right_arrow_white.png',
//                            width: 10,
//                            height: 10,
//                            fit: BoxFit.cover,
//                          ),
//                        ],
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
                      Text('工商信息',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 20,
                      ),
                     ListView.builder(itemBuilder: (BuildContext context,int index){
                       return GsItemwidget(gsInfos[index]);
                     },
                       itemCount: gsInfos.length,
                         shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics()
                     ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('在招职位',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 8,
                      ),

                      ListView.builder(itemBuilder: (BuildContext context,int index){
                        if(datalist.length ==0 || datalist[index]== null){

                          return Text("");
                        }else{
                          return PositionItem(datalist[index]);
                        }

                      },
                          itemCount: datalist.length >3 ? 3 :datalist.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics()
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomBtnWidget(
                        radius: 30,
                        fontSize: 12,
                        text:"查看所有职位",
                        btnColor: Colours.app_main,
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompanyJob(datalist),
                              ));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
//          BottomDrawerWidget(
//            child: buildJobDrawer(),
//            marginTop: kToolbarHeight,
//            smallHeight: 56,),
        ],
      ),
    );
  }



  Widget buildJobDrawer() {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        margin: EdgeInsets.only(top: kToolbarHeight),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 56,
              alignment: Alignment.centerLeft,
              child: Text('职位',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index < _jobList.length) {
                    return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: CompanyJobItem(
                            job: _jobList[index],
                            index: index,
                            lastItem: index == _jobList.length - 1),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobDetail(1),
                              ));
                        });
                  }
                  return null;
                },
                itemCount: _jobList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),);
  }
}
class GsItemwidget extends StatelessWidget{
  GSInfo gsInfo;
  GsItemwidget(this.gsInfo);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(gsInfo.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 14,
                    color: Colors.black54)),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(gsInfo.txt,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 14,
                      color: Colors.black54)),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

}



class PositionItem extends StatelessWidget{
  Map info;
  PositionItem(this.info);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Text(info["title"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 16,
                    color: Colors.black87)),
            SizedBox(
              height: 12,
            ),
         Text(info["salary"],

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      color: Colours.app_main)),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 4,
          color:Color(0xfff8f8f8),
        ),
      ],
    );
  }

}