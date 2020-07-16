import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/splash.dart';
import 'account/login/login_type.dart';

class RecruitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        primaryColor: new Color.fromARGB(255, 15, 185, 125),
        accentColor: Color.fromARGB(255, 15, 185, 125),
      ),
      home: Splash(),
      locale: Locale('zh'),
    );
  }
}
