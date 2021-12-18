import 'package:flutter_app_video/http/Http.dart';

class TinyVideoService {
  static const String rootPath = '/api/tinyVideo';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  static Future getTinyVideos({int page = 1, int limit = 10}) async {
    print("aaaaa  ==  $page");
    final response = await Http.post(
      listPath,
      data: {
        'page': page,
        'limit': limit,
      },
    );
    print("aaaaa  ==  $response  $page");
    Map<String, dynamic> result = response['page'];

    return result;
  }
}
