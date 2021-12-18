import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/AvatarRoleName.dart';
import 'package:flutter_app_video/components/CommentLiekRead.dart';
import 'package:flutter_app_video/config/AppConfig.dart';
import 'package:flutter_app_video/model/SongItem.dart';
import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';
import 'package:flutter_app_video/utils/PxUtils.dart';

class SongCard extends StatelessWidget {
  final SongItem songItem;
  const SongCard({Key key, this.songItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(toRpx(40, context)),
      child: Row(
        children: [
          _songConver(),
          SizedBox(
            width: 8,
          ),
          _songContent(),
        ],
      ),
    );
  }

  Widget _songContent() {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: Stack(
          children: [
            Text(
              songItem.cnName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.active,
                fontSize: 16,
              ),
            ),
            Positioned(
              top: 25,
              child: Text(
                songItem.enName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.un3active,
                  fontSize: 14,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: AvatarRoleName(
                      coverPictureUrl: songItem.user.coverPictureUrl,
                      nickname: songItem.user.nickname,
                      showType: false,
                      //type: 'DQ_OFFICIAL_ACCOUNT',
                    ),
                  ),
                  Expanded(
                    child: CommentLiekRead(
                      commentCount: songItem.commentCount,
                      thumbUpCount: songItem.thumbUpCount,
                      readCount: songItem.readCount,
                    ),
                    // child: CommentLiekRead(
                    //   commentCount: 121212111,
                    //   thumbUpCount: 33322000,
                    //   readCount: 1232,
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _songConver() {
    return SizedBox(
      width: 75,
      height: 75,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.assetNetwork(
              placeholder: '${ASSETS_IMAGES_COMMON}lazy-1.png',
              image: songItem.coverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              '${ASSETS_IMAGES_ICONS}tiny_video.png',
              width: 22,
              height: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
