import 'package:flutter_app_video/http/Http.dart';

class UserService {
  static const String rootPath = '/api/user';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  static Future getUsers({int page = 1, int limit = 10, String type}) async {
    final response = await Http.post(
      listPath,
      data: {
        'page': page,
        'limit': limit,
        'type': type,
      },
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
