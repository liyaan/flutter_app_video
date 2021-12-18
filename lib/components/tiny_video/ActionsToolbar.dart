import 'package:flutter/material.dart';
import 'package:flutter_app_video/config/AppConfig.dart';
import 'package:flutter_app_video/utils/PxUtils.dart';

class ActionsToolbar extends StatefulWidget {
  final int commentCount;
  final int thumbUpCount;
  final int shareCount;
  final bool thumbUp;
  final String userAvatar;
  final AnimationController animationController;

  ActionsToolbar({
    Key key,
    this.commentCount,
    this.thumbUpCount,
    this.shareCount,
    this.thumbUp,
    this.userAvatar,
    this.animationController,
  }) : super(key: key);

  @override
  _ActionsToolbarState createState() => _ActionsToolbarState();
}

class _ActionsToolbarState extends State<ActionsToolbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _avatar(),
        SizedBox(height: toRpx(38, context)),
        _iconText(
          icon: 'assets/images/icons/heart.png',
          count: widget.thumbUpCount,
          thumbUp: widget.thumbUp,
        ),
        SizedBox(height: toRpx(38, context)),
        _iconText(
          icon: 'assets/images/icons/comment2.png',
          count: widget.commentCount,
        ),
        SizedBox(height: toRpx(38, context)),
        _iconText(
          icon: 'assets/images/icons/share.png',
          count: widget.shareCount,
        ),
        SizedBox(height: toRpx(40, context)),
        _rotate(),
      ],
    );
  }

  // 头像
  Widget _avatar() {
    return Container(
      width: toRpx(90, context),
      height: toRpx(106, context),
      child: Stack(
        children: [
          Container(
            width: toRpx(90, context),
            height: toRpx(90, context),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(toRpx(90, context)),
            ),
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/common/lazy-1.png',
                image: networkImageToDefault(widget.userAvatar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: toRpx(38, context),
              height: toRpx(38, context),
              decoration: BoxDecoration(
                color: AppColors.danger,
                borderRadius: BorderRadius.circular(toRpx(38, context)),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 点赞评论。。。
  Widget _iconText({String icon, int count, bool thumbUp = false}) {
    return Column(
      children: [
        Image.asset(
          icon,
          width: toRpx(70, context),
          height: toRpx(70, context),
          color: thumbUp ? AppColors.danger : Colors.white,
        ),
        SizedBox(height: toRpx(4, context)),
        Text(
          formatCharCount(count),
          style: TextStyle(
            color: Colors.white,
            fontSize: toRpx(26, context),
          ),
        ),
      ],
    );
  }

  // 圆盘
  Widget _rotate() {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(widget.animationController),
      child: Container(
        width: toRpx(90, context),
        height: toRpx(90, context),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/common/bgm.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/common/lazy-1.png',
            image: networkImageToDefault(widget.userAvatar),
            width: toRpx(50, context),
            height: toRpx(50, context),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
