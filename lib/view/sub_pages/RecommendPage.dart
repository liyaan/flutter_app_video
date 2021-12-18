import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/ArticleCard.dart';
import 'package:flutter_app_video/components/AvatarRoleName.dart';
import 'package:flutter_app_video/components/SongCard.dart';
import 'package:flutter_app_video/components/TinyVideoCard.dart';
import 'package:flutter_app_video/components/VideoPlayCard.dart';
import 'package:flutter_app_video/model/ArticleItem.dart';
import 'package:flutter_app_video/model/RecommendInterface.dart';
import 'package:flutter_app_video/model/SongItem.dart';
import 'package:flutter_app_video/model/UserItem.dart';
import 'package:flutter_app_video/model/VideoItem.dart';
import 'package:flutter_app_video/services/ArticleSerice.dart';
import 'package:flutter_app_video/services/RecommendService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key key}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;
  List<RecommendInterface> _recommendList = [];
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  String errorMsg;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _getRecommends();
  }

  Future _getRecommends({bool replace = false}) async {
    try {
      List<dynamic> result = await RecommendService.getRecommend(
        page: page,
      );
      print(result);
      List<RecommendInterface> recommendList = result.map(
        (item) {
          if (item['videoEntity'] != null) {
            return VideoItem.fromJson(item['videoEntity']);
          } else if (item['userEntity'] != null) {
            return UserItem.fromJson(item['userEntity']);
          } else if (item['songEntity'] != null) {
            return SongItem.fromJson(item['songEntity']);
          } else if (item['articleEntity'] != null) {
            return ArticleItem.fromJson(item['articleEntity']);
          }
        },
      ).toList();
      print(recommendList);
      setState(() {
        page++;
        if (replace) {
          _recommendList.addAll(recommendList);
        } else {
          _recommendList = recommendList;
        }
      });
    } catch (e) {
      setState(() {
        print(e.toString());
        error = true;
        errorMsg = e.toString();
      });
    }
  }

  Future _onRefresh() async {
    page = 1;
    await _getRecommends();
    _controller.finishRefresh();
    _controller.resetLoadState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      controller: _controller,
      onRefresh: _onRefresh,
      footer: ClassicalFooter(),
      header: ClassicalHeader(),
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          RecommendInterface widgetItem = _recommendList[index];
          return getWidgetByInterface(widgetItem);
        },
        itemCount: _recommendList.length,
      ),
    );
  }

  Widget getWidgetByInterface(RecommendInterface widgetItem) {
    if (widgetItem is SongItem) {
      return _columnBox(SongCard(songItem: widgetItem));
    } else if (widgetItem is UserItem) {
      return _columnBox(AvatarRoleName(
        coverPictureUrl: widgetItem.coverPictureUrl,
        nickname: widgetItem.nickname,
        type: widgetItem.type,
      ));
    } else if (widgetItem is VideoItem) {
      return _columnBox(VideoPlayCard(videoItem: widgetItem));
    } else if (widgetItem is ArticleItem) {
      return _columnBox(ArtcleCard(articleItem: widgetItem));
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _columnBox(Widget card) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        card,
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
