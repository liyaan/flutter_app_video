import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/HomePageHead.dart';
import 'package:flutter_app_video/utils/MainViewBottomUtils.dart';
import 'package:flutter_app_video/view/sub_pages/SingerPage.dart';
import 'package:flutter_app_video/view/sub_pages/SongPage.dart';

class MusicPage extends StatefulWidget {
  MusicPage({Key key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

final List<Widget> _tabContainer = [
  SongPage(),
  SingerPage(),
];

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabMusic.length,
      vsync: this,
    );
    _tabController.addListener(() {
      // print(_tabController.index);
    });
    // getList();
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
          tabs: tabMusic,
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
