import 'package:flutter/material.dart';
import 'package:flutter_app_video/config/AppConfig.dart';
import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';
import 'package:flutter_app_video/utils/MainViewBottomUtils.dart';
import 'package:flutter_app_video/view/root_pages/HomePage.dart';
import 'package:flutter_app_video/view/root_pages/MusicPage.dart';
import 'package:flutter_app_video/view/root_pages/ProfilePage.dart';
import 'package:flutter_app_video/view/root_pages/TinyVideoPageHome.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class MainView extends StatefulWidget {
  const MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  final pageController = PageController();
  final List<BottomNavigationBarItem> _bottomNavigationList = [];
  // final List<IndexedStackChild> _pages = [
  //   IndexedStackChild(
  //     child: HomePage(),
  //   ),
  //   IndexedStackChild(
  //     child: MusicPage(),
  //   ),
  //   IndexedStackChild(
  //     child: Container(),
  //   ),
  //   IndexedStackChild(
  //     child: TinyVideoPageHome(),
  //   ),
  //   IndexedStackChild(
  //     child: ProfilePage(),
  //   ),
  // ];
  final List<Widget> _pages = [
    HomePage(),
    MusicPage(),
    Container(),
    TinyVideoPageHome(),
    ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
    bottomNames.forEach((key, value) {
      _bottomNavigationList.add(_bottomNavigationBarItem(key, value));
    });
  }

  void _onTabClick(int index) {
    if (index == 2) {
      return _onCreateMedia();
    }
    // setState(() {
    //   _currentIndex = index;
    // });
    pageController.jumpToPage(index);
  }

  // void onTap(int index) {
  //   pageController.jumpToPage(index);
  // }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onCreateMedia() {
    print("aaaa_meida");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationList,
        currentIndex: _currentIndex,
        onTap: _onTabClick,
      ),
      floatingActionButton: _createMediaButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // body: ProsteIndexedStack(
      //   index: _currentIndex,
      //   children: _pages,
      // ),
      // body:_pages[_currentIndex],
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: _pages,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
    );
  }

  Widget _createMediaButton() {
    return Container(
      width: 44,
      height: 44,
      margin: EdgeInsets.only(top: 56),
      child: FloatingActionButton(
        backgroundColor: AppColors.nav,
        elevation: 0,
        child: Image.asset("${ASSETS_IMAGES_ICONS}create_media.png"),
        onPressed: _onCreateMedia,
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String key, String value) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        '$ASSETS_IMAGES_ICONS$key.png',
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        '$ASSETS_IMAGES_ICONS${key}_active.png',
        width: 24,
        height: 24,
      ),
      label: value,
      tooltip: '',
    );
  }
}
