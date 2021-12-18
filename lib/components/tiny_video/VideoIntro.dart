import 'package:flutter/material.dart';
import 'package:flutter_app_video/utils/PxUtils.dart';
import 'package:marquee/marquee.dart';

class VideoIntro extends StatelessWidget {
  final String nickname;
  final String intro;
  const VideoIntro({Key key, this.nickname, this.intro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '@$nickname',
          style: TextStyle(
            color: Colors.white,
            fontSize: toRpx(30, context),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: toRpx(5, context)),
        Text(
          intro,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: toRpx(26, context),
          ),
        ),
        SizedBox(height: toRpx(5, context)),
        Row(
          children: [
            Image.asset(
              'assets/images/common/music.png',
              width: toRpx(36, context),
              height: toRpx(36, context),
              color: Colors.white,
            ),
            SizedBox(width: toRpx(5, context)),
            SizedBox(
              width: toRpx(370, context),
              height: toRpx(36, context),
              child: Marquee(
                text: '@$nickname创作的原声',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: toRpx(26, context),
                ),
                scrollAxis: Axis.horizontal,
                blankSpace: toRpx(30, context),
                velocity: 40.0,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
