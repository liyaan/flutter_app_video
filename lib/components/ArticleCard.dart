import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/AvatarRoleName.dart';
import 'package:flutter_app_video/components/CommentLiekRead.dart';
import 'package:flutter_app_video/config/AppConfig.dart';
import 'package:flutter_app_video/model/ArticleItem.dart';
import 'package:flutter_app_video/utils/ImageAssetsLoad.dart';
import 'package:flutter_app_video/utils/UserType.dart';

class ArtcleCard extends StatefulWidget {
  final ArticleItem articleItem;
  const ArtcleCard({Key key, this.articleItem}) : super(key: key);

  @override
  _ArtcleCardState createState() => _ArtcleCardState();
}

const double spaceSize = 10;
const double paddingSize = 20;

class _ArtcleCardState extends State<ArtcleCard> {
  double boxSize;
  @override
  Widget build(BuildContext context) {
    boxSize = MediaQuery.of(context).size.width - paddingSize * 2;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(paddingSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          SizedBox(
            height: paddingSize,
          ),
          _getCoverByType(),
          SizedBox(
            height: paddingSize,
          ),
          _bottom(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.articleItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.active,
        fontSize: 16,
      ),
    );
  }

  Widget _cover({int index = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: '${ASSETS_IMAGES_COMMON}lazy-1.png',
        image: widget.articleItem.coverUrlList[index],
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvatarRoleName(
            coverPictureUrl: widget.articleItem.user.coverPictureUrl,
            nickname: widget.articleItem.user.nickname,
            type: widget.articleItem.user.type,
          ),
        ),
        Expanded(
          child: CommentLiekRead(
            commentCount: widget.articleItem.commentCount,
            thumbUpCount: widget.articleItem.thumbUpCount,
            readCount: widget.articleItem.readCount,
          ),
        ),
      ],
    );
  }

  Widget _cover1() {
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: _cover(),
    );
  }

  Widget _cover2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 1),
        ),
      ],
    );
  }

  Widget _cover3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        SizedBox(
          height: spaceSize,
        ),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 1),
        ),
      ],
    );
  }

  Widget _cover4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
            SizedBox(
              height: spaceSize,
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cover5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              height: spaceSize,
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  Widget _cover6() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(
          height: spaceSize,
        ),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  Widget _cover7() {
    return Column(
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        SizedBox(
          height: spaceSize,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cover8() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(
          height: spaceSize,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 3),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getCoverByType() {
    int coverType = _getTypeByLength();
    Widget _coverWidget;
    switch (coverType) {
      case 2:
        _coverWidget = _cover2();
        break;
      case 3:
        _coverWidget = _cover3();
        break;
      case 4:
        _coverWidget = _cover4();
        break;
      case 5:
        _coverWidget = _cover5();
        break;
      case 6:
        _coverWidget = _cover6();
        break;
      case 7:
        _coverWidget = _cover7();
        break;
      case 8:
        _coverWidget = _cover8();
        break;
      default:
        _coverWidget = _cover1();
    }
    return _coverWidget;
  }

  int _getTypeByLength() {
    int length = widget.articleItem.coverUrlList.length;
    int coverType;
    switch (length) {
      case 2:
        coverType = getRandomRangeInt(2, 3);
        break;
      case 3:
        coverType = getRandomRangeInt(2, 7);
        break;
      case 4:
        coverType = getRandomRangeInt(2, 8);
        break;
      default:
        coverType = 1;
    }
    return coverType;
  }
}
