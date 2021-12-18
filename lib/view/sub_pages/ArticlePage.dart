import 'package:flutter/material.dart';
import 'package:flutter_app_video/components/ArticleCard.dart';
import 'package:flutter_app_video/model/ArticleItem.dart';
import 'package:flutter_app_video/services/ArticleSerice.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;
  List<ArticleItem> _articleList = ArticleList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  String errorMsg;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _getArticles();
  }

  Future _getArticles({bool replace = false}) async {
    try {
      print("dddddddddddddd");
      Map<String, dynamic> result = await ArticleService.getArticles(
        page: page,
      );
      List<dynamic> articleList = result['data'];
      ArticleList articleListModel = ArticleList.fromJson(articleList);
      print(articleListModel);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (replace) {
          _articleList.addAll(articleListModel.list);
        } else {
          _articleList = articleListModel.list;
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
    await _getArticles();
    _controller.finishRefresh();
    _controller.resetLoadState();
  }

  Future _onLoad() async {
    if (hasMore) {
      await _getArticles(replace: true);
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
              ArtcleCard(
                articleItem: _articleList[index],
              ),
            ],
          );
        },
        itemCount: _articleList.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
