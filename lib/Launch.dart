import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_video/MainView.dart';

import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';

class LaunchView extends StatefulWidget {
  LaunchView({Key key}) : super(key: key);

  @override
  _LaunchViewState createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> {
  int _currentTimer = 6;
  Timer _countdownTimer;
  @override
  void initState() {
    super.initState();
    _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTimer > 0) {
          _currentTimer--;
        } else {
          _justRootPage();
        }
      });
    });
  }

  void _justRootPage() {
    if (_currentTimer <= 3) {
      if (_countdownTimer != null) {
        _countdownTimer.cancel();
        _countdownTimer = null;
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MainView(),
          ),
          (route) => false);
      // Get.offNamed(AppRoutes.app);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            '${ASSETS_IMAGES_COMMON}page.png',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: InkWell(
              child: _clipButton(_currentTimer),
              onTap: _justRootPage,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _clipButton(currentTimer) {
  //container 中color和decoration 只能设置一个
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      border: new Border.all(width: 1, color: Colors.grey),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Offstage(
          child: Text(
            "跳过",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          offstage: currentTimer > 3,
        ),
        Text(
          "${currentTimer}s",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
            fontSize: 12,
          ),
        )
      ],
    ),
  );
}
