import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/SongCard.dart';
import 'package:flutter_app_video/model/SongItem.dart';
import 'package:flutter_app_video/services/SongService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SongPage extends StatefulWidget {
  SongPage({Key key}) : super(key: key);

  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;
  List<SongItem> _songList = SongList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  String errorMsg;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _getSongs();
  }

  Future _getSongs({bool replace = false}) async {
    try {
      Map<String, dynamic> result = await SongService.getSongsList(
        page: page,
      );
      List<dynamic> songList = result['data'];
      SongList songListModel = SongList.fromJson(songList);
      print(songListModel);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (replace) {
          _songList.addAll(songListModel.list);
        } else {
          _songList = songListModel.list;
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
    await _getSongs();
    _controller.finishRefresh();
    _controller.resetLoadState();
  }

  Future _onLoad() async {
    if (hasMore) {
      await _getSongs(replace: true);
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
              SongCard(
                songItem: _songList[index],
              ),
            ],
          );
        },
        itemCount: _songList.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
