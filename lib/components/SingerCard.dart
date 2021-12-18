import 'package:flutter/material.dart';
import 'package:flutter_app_video/config/AppConfig.dart';
import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';
import 'package:flutter_app_video/utils/PxUtils.dart';

class SingerCard extends StatelessWidget {
  final String coverPictureUrl;
  final String nickname;
  final int musicCount;
  final int musicPlayCount;
  const SingerCard({
    Key key,
    this.coverPictureUrl,
    this.nickname,
    this.musicCount,
    this.musicPlayCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: '${ASSETS_IMAGES_COMMON}lazy-1.png',
              image: coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Text(
            nickname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.active,
              fontSize: 16,
            ),
          ),
        ),
        Row(
          children: [
            _iconText('${ASSETS_IMAGES_ICONS}read.png', '歌曲', musicCount),
            _iconText('${ASSETS_IMAGES_ICONS}read.png', '播放', musicPlayCount),
          ],
        ),
      ],
    );
  }

  Widget _iconText(String icon, String label, int count) {
    return Expanded(
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 18,
            height: 18,
          ),
          Expanded(
            child: Text(
              '$label:${formatCharCount(count)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.unactive,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
