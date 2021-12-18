import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/TinyVideoCard.dart';

import 'package:flutter_app_video/model/VideoItem.dart';
import 'package:flutter_app_video/services/VideoService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class TinyVideoPage extends StatefulWidget {
  TinyVideoPage({Key key}) : super(key: key);

  @override
  _TinyVideoPageState createState() => _TinyVideoPageState();
}

class _TinyVideoPageState extends State<TinyVideoPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;
  List<VideoItem> _videoList = VideoList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  String errorMsg;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _getVideos();
  }

  Future _getVideos({bool replace = false}) async {
    try {
      print("aaaaaaaaaaa");
      Map<String, dynamic> result = await VideoService.getVideos(
        page: page,
        limit: 10,
      );
      List<dynamic> videoList = result['data'];
      VideoList videoListModel = VideoList.fromJson(videoList);
      print(videoListModel);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (replace) {
          _videoList.addAll(videoListModel.list);
        } else {
          _videoList = videoListModel.list;
        }
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMsg = e.toString();
      });
    }
  }

  Future _onRefresh() async {
    page = 1;
    await _getVideos();
    _controller.finishRefresh();
    _controller.resetLoadState();
  }

  Future _onLoad() async {
    if (hasMore) {
      await _getVideos(replace: true);
    }
    _controller.finishLoad(noMore: !hasMore);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      controller: _controller,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      footer: ClassicalFooter(),
      header: ClassicalHeader(),
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 1,
          childAspectRatio: 1 / 2,
        ),
        padding: EdgeInsets.only(
          top: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          bool isEven = index.isEven;
          double pl = isEven ? 18 : 9;
          double pr = isEven ? 9 : 18;
          return Container(
            padding: EdgeInsets.only(
              top: 18,
              left: pl,
              right: pr,
              bottom: 18,
            ),
            color: Colors.white,
            child: VideoCard(
              videoItem: _videoList[index],
            ),
          );
        },
        itemCount: _videoList.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
