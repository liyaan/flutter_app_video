import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/HomePageHead.dart';
import 'package:flutter_app_video/http/Http.dart';
import 'package:flutter_app_video/utils/MainViewBottomUtils.dart';
import 'package:flutter_app_video/view/sub_pages/ArticlePage.dart';
import 'package:flutter_app_video/view/sub_pages/RecommendPage.dart';
import 'package:flutter_app_video/view/sub_pages/SingerPage.dart';
import 'package:flutter_app_video/view/sub_pages/SongPage.dart';
import 'package:flutter_app_video/view/sub_pages/TinyVideoPage.dart';
import 'package:flutter_app_video/view/sub_pages/VideoPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final List<Widget> _tabContainer = [
  SongPage(),
  RecommendPage(),
  SingerPage(),
  TinyVideoPage(),
  ArticlePage(),
  VideoPalyPage(),
];

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 1,
      length: tab.length,
      vsync: this,
    );
    _tabController.addListener(() {
      // print(_tabController.index);
    });
    // getList();
  }

  Future getList() async {
    final result = await Http.get("/api/song/info/1");
    print(result);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HomePageHead(),
        bottom: TabBar(
          tabs: tab,
          controller: _tabController,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        children: _tabContainer,
        controller: _tabController,
      ),
    );
  }
}
