import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'jobs/job_detail.dart';
import 'jobs/job_row_item.dart';
import 'blur_rect.dart';

class JZJXPage extends StatefulWidget{
  String url;
 JZJXPage(this.url);

  @override
  _JZState createState() {
    // TODO: implement createState
    return _JZState();
  }

}

class _JZState extends State<JZJXPage>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int page;
  List data =List();
 String url;
  _OnRefresh(){

    new MiviceRepository().getJzList(url).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        setState(() {
          data = reponse["result"];
        });
        print(data);
        page++;

      }
      _refreshController.refreshCompleted();
    });
  }
  _loadMore(){

      _refreshController.loadComplete();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: Flex(
        direction:Axis.vertical ,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Stack(
              overflow: Overflow.clip,
              alignment: Alignment.center,
              children: <Widget>[
                // 背景图片
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Color(0xffF3F4F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      image: DecorationImage(
                          image: AssetImage("images/banner_zp.png"),
                          fit: BoxFit.cover) //设置图片的填充模式
                  ),
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                ),
                // 矩形高斯模糊效果
                BlurRectWidget(
                  child: Container(height: 100,),
                  sigmaY: 5,
                  sigmaX: 5,
                ),
                Text(
                  "精选",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                Positioned(
                  left: 12,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                    onPressed:()=> Navigator.of(context).pop(),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SmartRefresher(

                header: WaterDropHeader(),
                footer: ClassicFooter(),
                controller: _refreshController,
                onRefresh: _OnRefresh,
                onLoading: _loadMore,
                enablePullUp: true,
                child: ListView.builder(itemBuilder: (context, index) {
                  if (data.length >0 && index < data.length) {
                    return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: JobRowItem(
                            job: data[index],
                            index: index,
                            lastItem: index == data.length - 1),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>JobDetail(data[index]["job_id"]),
                              ));
                        });
                  }else{
                    return  Center(
                        child:  Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("images/empty_work.png",width: 60,height: 60,),
                            Text(
                                "暂未搜到相关数据"
                            )
                          ],
                        )
                    );
                  }

                },
                  itemCount: data.length,
                )
            ),
          )
        ],
      )
    );
  }


}