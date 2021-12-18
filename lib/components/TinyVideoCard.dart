import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/AvatarRoleName.dart';
import 'package:flutter_app_video/components/CommentLiekRead.dart';
import 'package:flutter_app_video/model/VideoItem.dart';
import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';

class VideoCard extends StatelessWidget {
  final VideoItem videoItem;
  const VideoCard({Key key, this.videoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _cover(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: AvatarRoleName(
            coverPictureUrl: videoItem.user.coverPictureUrl,
            nickname: videoItem.user.nickname,
            type: videoItem.user.type,
            avatarSize: 20,
          ),
        ),
        CommentLiekRead(
          commentCount: videoItem.commentCount,
          thumbUpCount: videoItem.thumbUpCount,
          readCount: videoItem.readCount,
        ),
      ],
    );
  }

  Widget _cover() {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: '${ASSETS_IMAGES_COMMON}lazy-3.png',
              image: videoItem.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              '${ASSETS_IMAGES_ICONS}tiny_video.png',
              color: Colors.white,
              width: 38,
              height: 38,
            ),
          ),
        ],
      ),
    );
  }
}
