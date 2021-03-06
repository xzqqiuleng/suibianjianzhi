import 'package:flutter/material.dart';
import 'package:recruit_app/pages/home/search_bar.dart';
import 'package:recruit_app/pages/jobs/all/job_libsboard.dart';


class JobSearchPage extends StatefulWidget {
 String searchTxt;
  JobSearchPage(this.searchTxt,{Key key}):super(key:key);

  @override
  _JobSearchPageState createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //修改颜色
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: SearchBar('images/icon_home_search_20x20_@3x.png',height: 32,
            backgroudColor:  Color(0xfff0f0f0),txt: widget.searchTxt,
          ),
        ),
        body:  new JobLibsboard(searchTxt:widget.searchTxt)
      );
  }
}