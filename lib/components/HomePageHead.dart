import 'package:flutter/material.dart';
import 'package:flutter_app_video/config/AppConfig.dart';
import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';

class HomePageHead extends StatelessWidget {
  const HomePageHead({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          '${ASSETS_IMAGES_COMMON}logo.png',
          height: 40,
        ),
        Expanded(
          child: _searchContent(),
        ),
        Image.asset(
          '${ASSETS_IMAGES_ICONS}msg.png',
          height: 30,
        ),
      ],
    );
  }

  Widget _searchContent() {
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.page,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 16,
            color: AppColors.un3active,
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            '搜索关键字',
            style: TextStyle(
              color: AppColors.un3active,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
