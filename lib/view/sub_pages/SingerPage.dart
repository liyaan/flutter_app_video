import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/SingerCard.dart';
import 'package:flutter_app_video/model/UserItem.dart';
import 'package:flutter_app_video/services/UserService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SingerPage extends StatefulWidget {
  SingerPage({Key key}) : super(key: key);

  @override
  _SingerPageState createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;
  List<UserItem> _singerList = UserList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  String errorMsg;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    // _getUsers();
  }

  Future _getUsers({bool replace = false}) async {
    try {
      print("aaaaaaaaaaaaaaa");
      Map<String, dynamic> result = await UserService.getUsers(
        page: page,
        type: '',
      );

      List<dynamic> singerList = result['data'];
      print(singerList);
      UserList singerListModel = UserList.fromJson(singerList);
      print(singerList);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (replace) {
          _singerList.addAll(singerListModel.list);
        } else {
          _singerList = singerListModel.list;
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
    await _getUsers();
    _controller.finishRefresh();
    _controller.resetLoadState();
  }

  Future _onLoad() async {
    if (hasMore) {
      await _getUsers(replace: true);
    }
    // _controller.resetRefreshState();
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
        child: _singerGridView());
  }

  Widget _singerGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: MediaQuery.of(context).size.width / 1.5,
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 1,
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
          child: SingerCard(
            coverPictureUrl: _singerList[index].coverPictureUrl,
            nickname: _singerList[index].nickname,
            musicCount: _singerList[index].musicCount,
            musicPlayCount: _singerList[index].musicPlayCount,
          ),
        );
      },
      itemCount: _singerList.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
