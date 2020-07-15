import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/bm_result.dart';
import 'package:recruit_app/pages/companys/company_detail.dart';
import 'package:recruit_app/pages/constant.dart';
import 'package:recruit_app/pages/jobs/chat_room.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/widgets/dash_line.dart';
import 'job_row_item.dart';

class JobDetail extends StatefulWidget {
  int id;
  JobDetail(this.id);
  @override
  _JobDetailState createState() {
    // TODO: implement createState
    return _JobDetailState();
  }
}
//这次基础款结帐一次，以后每次大版本更新再另算（包括新需求，新模块）。小功能的话，修bug免费。
class _JobDetailState extends State<JobDetail> {
  Map infors ;
  List datalist=List() ;
  List<String> labels;
  List<Widget> itemWidgetList=[];
  List<Widget> contentWidget=[];
  String userImg="https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2519824424,1132423651&fm=26&gp=0.jpg";
  String user="HR发布";
  Map summary;
  Map com_label;
  String address = "暂无地址";
  String compay_desc = "暂无公司信息";
  _loadData(){

 if(widget.id == null){
   widget.id = 113546932;
 }
    new MiviceRepository().getJobDetail(widget.id).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        var   data = reponse["result"];

        print(data);
        setState(() {
          infors = data["info"];  //"com_id" -> 10057  "job_id" -> 120587312
          datalist = data["jobs"];
           summary = json.decode(infors["summary"].toString());

           if(infors["com_label"] !=null && infors["com_label"] != ""){
             com_label = json.decode(infors["com_label"].toString());
           }

      print(infors["company_img"]);

          labels = infors["label"].toString().split("|");

          if(infors["pub_img"] == ""){
            userImg = infors["mook_img"];
          }else{
            userImg = infors["pub_img"];
          }
          if(infors["pub_person"] != ""){
            user = infors["pub_person"];
          }
          _getLabel();
          _getContent();
        });

      }
    });
  }
  Widget _getTip(){
  List<Widget> tipWidget=[];
  List<Widget> columWidget=[];
  columWidget.add(SizedBox(height: 10));
     if(infors != null &&infors["tip"] != "" &&infors["tip"] != "无"){
       List<String>tips = infors["tip"].toString().split(" ");
       columWidget.add(Text("福利待遇",
           maxLines: 1,
           overflow: TextOverflow.ellipsis,
           style: const TextStyle(
               wordSpacing: 1,
               letterSpacing: 1,
               fontSize: 16,
               fontWeight: FontWeight.bold,
               color: Color.fromRGBO(37, 38, 39, 1))));
       columWidget.add(SizedBox(height: 12));
       for (var item in tips){
         if(item == " "||item ==""){
           continue;
         }
         tipWidget.add( TextTagWidget("$item",
           backgroundColor: Colors.white,
           margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
           padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
           borderRadius: 2,
           borderColor: Color(0xFFF0F0F0),
           textStyle: TextStyle(
               color: Colors.black87,
               fontSize: 14
           ),
         ));
       }

       columWidget.add(Wrap(children: tipWidget));
       columWidget.add(SizedBox(height: 18));

     }else{
       columWidget.add(Container(height: 0,));
     }

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: columWidget,
  );
  }
  Widget _getContent(){

   summary.forEach((key, value) {
      if(key != "公司信息"){
        contentWidget.add( Text(key.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))));
        contentWidget.add(SizedBox(
          height: 8,
        ));
        contentWidget.add(Html(data: value.toString().replaceAll("微信分享", "").replaceAll("地图", "")));
      }

   });
   if(com_label != null && com_label.length>0){
     compay_desc = "";
     com_label.forEach((key, value) {
       if(key.toString().contains("地")){
         address = com_label[key].toString();
       }
       compay_desc = compay_desc+ com_label[key]+"·";
     });
   }

  }
  Widget _getLabel(){
    if(labels != null && labels.length >0){


      for (var i = 0; i < labels.length; i++) {
        var str = labels[i];
        itemWidgetList.add(TextTagWidget("$str",
        backgroundColor: Color(0xFFF0F0F0),
          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
          padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
          borderColor: Color(0xFFF0F0F0),
          borderRadius: 2,
          textStyle: TextStyle(
            color: Colors.black38,
          fontSize: 12
          ),
        ));
      }

    }
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Image.asset(
                'images/ic_back_arrow.png',
                width: 20,
                height: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          actions: <Widget>[
            IconButton(
                icon: Image.asset(
                  'images/ic_action_favor_off_black.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {}),
            IconButton(
                icon: Image.asset(
                  'images/ic_action_report_black.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {})
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 18, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(infors == null? "":infors["title"],

                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                      SizedBox(
                        height: 10,
                      ),
                      Text(infors == null? "":infors["salary"],
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colours.app_main)),
                      SizedBox(
                        height: 16,
                      ),
                   Row(
                     children: <Widget>[
                       Image.asset("images/d_label1.png",width: 16,height: 16,),
                       SizedBox(
                         width: 4,
                       ),
                       Text(
                         "2020-3-20",
                         style: TextStyle(
                           color: Color(0xff515151)
                         ),
                       ),
                       SizedBox(
                         width: 16,
                       ),
                       Image.asset("images/d_label2.png",width: 16,height: 16,),
                       SizedBox(
                         width: 4,
                       ),
                       Text(
                         "2",
                         style: TextStyle(
                             color: Color(0xff515151)
                         ),
                       ),
                       SizedBox(
                         width: 16,
                       ),
                       Image.asset("images/d_label3.png",width: 16,height: 16,),
                       SizedBox(
                         width: 4,
                       ),
                       Text(
                         "3",
                         style: TextStyle(
                             color: Color(0xff515151)
                         ),
                       )

                     ],

                   ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:   Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            runAlignment: WrapAlignment.start,
                            alignment: WrapAlignment.start,
                            ///子标签
                            children: itemWidgetList),

                      ),

                      Container(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        height: 2,
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: contentWidget,
                      ),

                      Container(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        height: 2,
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                      ),
                      Text('公司信息',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                      SizedBox(height: 16),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              child: Image.network(
                                  (infors == null|| !infors["company_img"].toString().contains("http"))?Constant.deault_compay:infors["company_img"],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(infors == null?"":infors["company"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            wordSpacing: 1,
                                            letterSpacing: 1,
                                            fontSize: 14,
                                            color: Color.fromRGBO(37, 38, 39, 1))),
                                    SizedBox(height: 5),
                                    Text(compay_desc,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            wordSpacing: 1,
                                            letterSpacing: 1,
                                            fontSize: 12,
                                            color: Colors.black54)),
                                  ],
                                )),
                            SizedBox(width: 15),
                            Image.asset('images/ic_arrow_gray.png',
                                width: 10, height: 10, fit: BoxFit.cover)
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompanyDetail(infors["com_id"])));
                        },
                      ),
                      Container(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        height: 2,
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                      ),
                      Text('报名流程',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[

                             Container(
                                width: 80,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image:DecorationImage(
                                        image:AssetImage("images/lc_tab.png")
                                    )
                                ),
                                child: Text(
                                    "流程一",
                                    style: TextStyle(
                                      color: Colors.white,

                                    )
                                ),
                              ),
                           SizedBox(width: 40),
                            Text(
                                "职位报名",
                              style: TextStyle(
                                color: Colors.black87,

                              ),
                            )
                          ],
                        ),

                      Row(
                        children: <Widget>[

                          Image.asset("images/lc_line.png",height: 60,),
                          SizedBox(width: 60),
                          Text(
                            "确认工作详情之后，点击报名",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12
                            )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              width: 80,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image:DecorationImage(
                                      image:AssetImage("images/lc_tab.png")
                                  )
                              ),
                              child: Text(
                                  "流程二",
                                  style: TextStyle(
                                    color: Colors.white,

                                  )
                              ),
                            ),
                          SizedBox(width: 40),
                          Text(
                            "联系企业           ",
                            style: TextStyle(
                              color: Colors.black87,

                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[
                        Image.asset("images/lc_line.png",height: 60,),
                          SizedBox(width: 60),
                          Text(
                              "主动添加微信，核实企业联系",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              width: 80,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image:DecorationImage(
                                      image:AssetImage("images/lc_tab.png")
                                  )
                              ),
                              child: Text(
                                  "流程三",
                                  style: TextStyle(
                                    color: Colors.white,

                                  )
                              ),
                            ),
                          SizedBox(width: 40),
                          Text(
                            "开始工作           ",
                            style: TextStyle(
                              color: Colors.black87,

                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[
                         Image.asset("images/lc_line.png",height: 60,),
                          SizedBox(width: 60),
                          Text(
                              "双方同意工作内容，签约上班",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[

                          Container(
                              width: 80,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image:DecorationImage(
                                      image:AssetImage("images/lc_tab.png")
                                  )
                              ),
                              child: Text(
                                  "流程四",
                                  style: TextStyle(
                                    color: Colors.white,

                                  )
                              ),
                            ),
                          SizedBox(width: 40),
                          Text(
                            "完成兼职           ",
                            style: TextStyle(
                              color: Colors.black87,

                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[

                           Image.asset("images/lc_line.png",height: 60,color: Colors.white,),
                          SizedBox(width: 60),
                          Text(
                              "无违约，等待企业发放薪资中",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xfffff7de)
                        ),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
 
                          Text(
                          "如遇无效、虚假、诈骗信息，请立即举报",
                          style: TextStyle(
                              color: Color(0xffff552e),
                              fontSize: 13,
                            fontWeight: FontWeight.bold
                          )
                          ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "1.求职过程中签订劳动合同或没入职前请勿缴纳费用及押金、请勿参与刷单、彩票赌博、YY网络兼职、QT语音兼职职位等事项均为骗子,谨防诈骗！若信息不实请举报。\n2.对学历、经验、技能无任何要求，且承诺能快速赚取高薪的招聘职位，均有传销诈骗嫌疑，请提高警惕查看招聘详情。",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12
                                )
                            )
                          ],
                        ) ,
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('相关职位',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                      SizedBox(
                        height: 8,
                      ),
                      ListView.builder(itemBuilder: (context, index) {
                        if (datalist.length >0 && index < datalist.length) {
                          return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: JobDetailRowItem(
                                  job: datalist[index],
                                  index: index,
                                  lastItem: index == datalist.length - 1),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetail(datalist[index]["job_id"]),
                                    ));
                              });
                        }
                        return null;
                      },
                        itemCount: datalist.length,
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics()
                      )
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: MaterialButton(
                    color: Colours.app_main,
                    onPressed: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => ChatRoom(head_icon: userImg,title: user,reply_id: "",)));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BmResult()));
                    },
                    textColor: Colors.white,
                    child: Text("立即沟通"),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  )),
            ),
          ],
        ));
  }
}
class JobDetailRowItem extends StatelessWidget {
  final Map<String,dynamic> job;
  final int index;
  final bool lastItem;
  final bool isJi;
  final bool isBz;

  const JobDetailRowItem({Key key, this.job, this.index, this.lastItem,this.isJi,this.isBz})
      : super(key: key);


  Widget getImg(String imgUrl){
    if(imgUrl.contains("http")){
      return  ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(28)),
        child: Image.network(
          imgUrl,
          width: ScreenUtil().setWidth(56),
          height: ScreenUtil().setWidth(56),
          fit: BoxFit.cover,
        ),
      );
    }else{
      return Container(
        alignment: Alignment.center,
        height: 28,
        width: 28,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color:Colours.slRandomColor()
        ),
        child: Text(
          imgUrl,
          style: TextStyle(
              fontSize: 10,
              color: Colors.white
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobItem = Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
        ),
        color: Colors.white,
        elevation: 0.5,
        margin: EdgeInsets.only(

            top: ScreenUtil().setWidth(22),
            bottom: 0),
        child: Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(28),
              right: ScreenUtil().setWidth(28),
              top: ScreenUtil().setWidth(20),
              bottom: ScreenUtil().setWidth(20)),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            job["title"].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(32),
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(20, 20, 20, 1),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(job["salary"].toString(),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          fontWeight: FontWeight.bold,
                          color: Colours.app_main)),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(20),
              ),
              Text(
                job["label"].toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(23),
                  color: Color.fromRGBO(151, 151, 151, 1),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(28),
              ),
              DashLine(
                color: Colors.black12,
                height: 0.4,
                dashWidth:2,
              ),
              Offstage(
                  offstage: (isJi == null || isJi == false) ? true :false,
                  child : Container(
                    margin: EdgeInsets.fromLTRB(0,10,0,0),
                    padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                    decoration: BoxDecoration(
                      color: Colours.app_main.withOpacity(0.2),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset("images/ji.png",height: 16,width: 16,),
                        SizedBox(width: 6,),
                        Text(
                          "2020-07-12前停止招聘",
                          style: TextStyle(
                              color: Colours.app_main,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),

                  )
              ),
              Offstage(
                  offstage: (isBz == null || isBz == false) ? true :false,
                  child : Container(
                    margin: EdgeInsets.fromLTRB(0,10,0,0),
                    padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                    decoration: BoxDecoration(
                      color: Colours.blue_main.withOpacity(0.2),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset("images/bz.png",height: 16,width: 16,),
                        SizedBox(width: 6,),
                        Text(
                          "官方保障，24小时跟踪！",
                          style: TextStyle(
                              color: Colours.blue_main,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),

                  )
              ),

              SizedBox(
                height: ScreenUtil().setWidth(28),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  getImg(job["company_img"].toString()),
                  SizedBox(
                    width: ScreenUtil().setWidth(12),
                  ),
                  Flexible(
                    child: Text(
                      job["pub_person"].toString()==""?"HR发布":job["pub_person"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        color: Color.fromRGBO(57, 57, 57, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      job["pub_date"].toString(),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(22),
                        color: Color.fromRGBO(176, 181, 180, 1),
                      ),
                    ),
                  )

                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(18),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[


                  Image.asset(
                    'images/qyrz.png',
                    width: ScreenUtil().setWidth(24),
                    height: ScreenUtil().setWidth(24),
                    fit: BoxFit.cover,
                  ),

                  SizedBox(
                    width: ScreenUtil().setWidth(4),
                  ),
                  Flexible(
                    child: Text(
                      job["company"].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(22),
                        color: Color.fromRGBO(57, 57, 57, 1),
                      ),
                    ),
                  ),



                ],
              ),

            ],
          ),
        )
    );

    if (lastItem) {
      return jobItem;
    }
    return Column(
      children: <Widget>[
        jobItem,
      ],
    );
  }
}