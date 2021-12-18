import 'package:flutter/material.dart';
import 'package:flutter_app_video/config/AppConfig.dart';
import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';
import 'package:flutter_app_video/utils/PxUtils.dart';

class CommentLiekRead extends StatelessWidget {
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  const CommentLiekRead({
    Key key,
    this.commentCount,
    this.thumbUpCount,
    this.readCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _iconText('${ASSETS_IMAGES_ICONS}comment.png', commentCount),
        _iconText('${ASSETS_IMAGES_ICONS}like.png', thumbUpCount),
        _iconText('${ASSETS_IMAGES_ICONS}read.png', readCount),
      ],
    );
  }

  Widget _iconText(String icon, int count) {
    return Expanded(
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 18,
            height: 18,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              formatCharCount(count),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.un3active,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
