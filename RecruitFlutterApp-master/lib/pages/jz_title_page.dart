import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'jobs/job_detail.dart';
import 'jobs/job_row_item.dart';

class JZTitlePage extends StatefulWidget{
      String title;
 JZTitlePage(this.title);

  @override
  _JZState createState() {
    // TODO: implement createState
    return _JZState();
  }

}

class _JZState extends State<JZTitlePage>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  List data =List();
 String url;
 int page;
  _OnRefresh(){
    page = 2;
    if(widget.title == "网上兼职"){
      url = "http://www.zaojiong.com/job/list/985-0-0-0_0_0_0_0_0_0_0-0-0-0-${page}.html";
    }else{
      url = "http://www.zaojiong.com/job/list/45-0-0-0_0_0_0_0_0_0_0-0-0-0-${page}.html";
    }

    new MiviceRepository().getJzList(url).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        setState(() {
          data = reponse["result"];
        });
        page++;
        print(data);
      }
      _refreshController.refreshCompleted();
    });
  }
  _loadMore(){
    if(widget.title == "网上兼职"){
      url = "http://www.zaojiong.com/job/list/985-0-0-0_0_0_0_0_0_0_0-0-0-0-${page}.html";
    }else{
      url = "http://www.zaojiong.com/job/list/45-0-0-0_0_0_0_0_0_0_0-0-0-0-${page}.html";
    }

    new MiviceRepository().getJzList(url).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        List  loaddata = reponse["result"];
        setState(() {
          data.addAll(loaddata);
        });

        page++;

      }
      _refreshController.loadComplete();
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))),
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SmartRefresher(

          header: WaterDropHeader(),
          footer: ClassicFooter(),
          controller: _refreshController,
          onRefresh: _OnRefresh,
          onLoading: _loadMore,
          enablePullUp: true,
          child: data.length == 0 ? Center(
      child:  Column(
      mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("images/empty_work.png",width: 60,height: 60,),
          Text(
              "暂未搜到相关数据"
          )
        ],
      )
    ):ListView.builder(itemBuilder: (context, index) {
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
                          builder: (context) =>JobDetail(0,url: data[index]["jobHref"]),
                        ));
                  });
            }

          },
            itemCount: data.length,
          )
      )
    );
  }


}