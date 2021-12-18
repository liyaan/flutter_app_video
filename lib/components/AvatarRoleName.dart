import 'package:flutter/material.dart';
import 'package:flutter_app_video/config/AppConfig.dart';
import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';
import 'package:flutter_app_video/utils/UserType.dart';

class AvatarRoleName extends StatelessWidget {
  final String coverPictureUrl;
  final String nickname;
  final bool showType;
  final String type;
  final double avatarSize;
  const AvatarRoleName({
    Key key,
    this.coverPictureUrl,
    this.nickname,
    this.showType = true,
    this.type,
    this.avatarSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _avatar(),
        Offstage(
          offstage: !showType,
          child: _role(),
        ),
        _nickname(),
      ],
    );
  }

  Widget _avatar() {
    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: '${ASSETS_IMAGES_COMMON}lazy-1.png',
          image: coverPictureUrl,
        ),
      ),
    );
  }

  Widget _role() {
    return Container(
      margin: EdgeInsets.only(left: 6),
      padding: EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: UserType.formColor(type),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        UserType.formCn(type),
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _nickname() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          left: 6,
        ),
        child: Text(
          nickname,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.unactive,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
