import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/jzjxpage.dart';

class JXPageTab extends StatefulWidget {
  @override
  _JXPageTabState createState() => _JXPageTabState();
}

class _JXPageTabState extends State<JXPageTab> {

  List<String> images =["images/zt_a1.png","images/zt_a2.png","images/zt_a3.png","images/zt_a4.png","images/zt_a5.png"];
  List<String> imageZs =["images/zt1.jpg","images/zt2.png","images/zt3.png","images/zt4.jpg"];
  List<String> txt=["周末兼职","模特T台","主播聊天","家教辅导","抖音视频"];
  List<String> txtS=["校内兼职推荐","线上兼职专场","兼职赚钱攻略","潮兼职，等你来"];
  List<String> txDesc=["校内兼职每周更新，专为学生打造的专栏","线上兼职聚集地，在家也能完成的兼职工作","小编精选，快速兼职赚钱新套路","潮兼职，新潮流，不一样的奇妙兼职工作"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("精选专栏",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/zt_top.jpg"),
                fit: BoxFit.fill
              )
            ),
            ),
            SizedBox(
              height: 16,
            ),
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:5 ,//每行三列
                    childAspectRatio: 1.0 //显示区域宽高相等
                ),
                itemCount: images.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  //如果显示到最后一个并且Icon总数小于200时继续获取数据
                  return Column(
                    children: [
                      Image.asset(images[index],width: 40,height: 40,),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        txt[index],

                      ),

                    ],
                  );
                }
            ),
            ListView.builder(itemBuilder:(context, index) {

                 return GestureDetector(
                   behavior: HitTestBehavior.opaque,
                   onTap: (){
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => JZJXPage(index)));
                   },
                   child: Padding(
                       padding: EdgeInsets.all(12),
                       child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.stretch,
                           children: [
                             Container(
                               margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                               height: 120,
                               decoration: BoxDecoration(
                                 image: DecorationImage(
                                   image: AssetImage(imageZs[index]),
                                   fit: BoxFit.fill,
                                 ),
                                 borderRadius: BorderRadius.circular(4),
                               ),
                             ),
                             SizedBox(
                               height: 2,
                             ),
                             Text(
                               txtS[index],
                               style: TextStyle(
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                             SizedBox(
                               height: 2,
                             ),
                             Text(
                               txDesc[index],
                               style: TextStyle(
                                   fontSize: 12,
                                   color: Colors.grey
                               ),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Container(
                               height: 4,
                               color: Color(0xfff0f0f0),
                             )
                           ]
                       )
                   )
                 );
             },
            itemCount: imageZs.length,
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics()
            )
          ],

        )
      ),
    );
  }
}
