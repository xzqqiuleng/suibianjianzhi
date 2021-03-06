import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'jobs/job_detail.dart';
import 'jobs/job_row_item.dart';

class JzTitl extends StatefulWidget{
      String title;
      String url;
 JzTitl(this.title,this.url);

  @override
  _JZState createState() {
    // TODO: implement createState
    return _JZState();
  }

}

class _JZState extends State<JzTitl>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  List data =List();

  _OnRefresh(){


    new MiviceRepository().getJzList(widget.url).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        setState(() {
          data = reponse["result"];
        });
        print(data);
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
                          builder: (context) =>JobDetail(0,url:data[index]["jobHref"]),
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