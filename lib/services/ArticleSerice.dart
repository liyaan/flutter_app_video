import 'package:flutter_app_video/http/Http.dart';

class ArticleService {
  static const String rootPath = '/api/article';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  static Future getArticles({int page = 1, int limit = 10}) async {
    final response = await Http.post(
      listPath,
      data: {
        'page': page,
        'limit': limit,
      },
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
