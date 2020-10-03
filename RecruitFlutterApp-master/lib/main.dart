import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/pages/recruit_app.dart';
import 'package:recruit_app/pages/storage_manager.dart';

//void main() => runApp(ChangeNotifierProvider<IdentityModel>(create: (context)=>IdentityModel(),child: RecruitApp(),));
void main() async {
  runApp(MyApp());
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  JPush jpush = new JPush();
  jpush.setup(
    appKey: "c617b6aa7cd0d4a17f48e2aa",
    channel: "theChannel",
    production: false,
    debug: false, // 设置是否打印 debug 日志
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: ChangeNotifierProvider<IdentityModel>(
      create: (context)=>IdentityModel(),child: RecruitApp(),
    )

    );
  }
}
