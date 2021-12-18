import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_video/Launch.dart';

import 'config/AppTheme.dart';

void main() {
  if (Platform.isAndroid) {
    // 沉浸式状态栏
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      /// 这是设置状态栏的图标和字体的颜色
      /// Brightness.light  一般都是显示为白色
      /// Brightness.dark 一般都是显示为黑色
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '视频',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   primaryColor: Color.fromARGB(255, 85, 132, 250),
      //   accentColor: Color.fromARGB(255, 85, 132, 250),
      //   appBarTheme: AppBarTheme(
      //     textTheme: TextTheme(
      //       headline6: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal),
      //     ),
      //     elevation: 0,
      //   ),
      //   scaffoldBackgroundColor: Color.fromARGB(255, 245, 246, 250),
      // ),
      // initialRoute: AppRouter.initialRoute,
      // unknownRoute: AppRouter.unknownRoute,
      // getPages: AppRouter.getPages,
      home: LaunchView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LaunchView(),
    );
  }
}
