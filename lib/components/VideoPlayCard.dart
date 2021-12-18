import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/AvatarRoleName.dart';
import 'package:flutter_app_video/components/CommentLiekRead.dart';
import 'package:flutter_app_video/config/AppConfig.dart';
import 'package:flutter_app_video/model/VideoItem.dart';
import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';
import 'package:flutter_app_video/utils/UserType.dart';

class VideoPlayCard extends StatefulWidget {
  final VideoItem videoItem;
  VideoPlayCard({Key key, this.videoItem}) : super(key: key);

  @override
  _VideoPlayCardState createState() => _VideoPlayCardState();
}

class _VideoPlayCardState extends State<VideoPlayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          SizedBox(
            height: 20,
          ),
          _getCoverByType(),
          SizedBox(
            height: 20,
          ),
          _bottom(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.videoItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.active,
        fontSize: 16,
      ),
    );
  }

  Widget _getCoverByType() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: '${ASSETS_IMAGES_COMMON}lazy-2.png',
              image: widget.videoItem.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              "${ASSETS_IMAGES_ICONS}play_plus.png",
              width: 60,
              height: 60,
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                secondsToTime(
                  widget.videoItem.contentSeconds,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvatarRoleName(
            coverPictureUrl: widget.videoItem.user.coverPictureUrl,
            nickname: widget.videoItem.user.nickname,
            type: widget.videoItem.user.type,
          ),
        ),
        Expanded(
          child: CommentLiekRead(
            commentCount: widget.videoItem.commentCount,
            thumbUpCount: widget.videoItem.thumbUpCount,
            readCount: widget.videoItem.readCount,
          ),
        ),
      ],
    );
  }
}
