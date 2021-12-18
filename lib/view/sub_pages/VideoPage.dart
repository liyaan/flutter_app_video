import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/VideoPlayCard.dart';
import 'package:flutter_app_video/model/VideoItem.dart';
import 'package:flutter_app_video/services/VideoService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class VideoPalyPage extends StatefulWidget {
  const VideoPalyPage({Key key}) : super(key: key);

  @override
  _VideoPalyPageState createState() => _VideoPalyPageState();
}

class _VideoPalyPageState extends State<VideoPalyPage>
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
      print("dddddddddddddd");
      Map<String, dynamic> result = await VideoService.getVideos(
        page: page,
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
        print(e.toString());
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
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(
                height: 8,
              ),
              VideoPlayCard(
                videoItem: _videoList[index],
              ),
            ],
          );
        },
        itemCount: _videoList.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
