import 'package:http/http.dart' as http;

import '../../../util/config.dart';

class RestApis {
  static Future<http.Response> deleteListItem(String id) async {
    var token = await _getAccessToken();

    return http.delete(
      Uri.https(
        Config.instance.kRestApiBaseURL,
        'api/posts',
        {'id': id},
      ),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  static Future<String?> _getAccessToken() async {
    // var token = await SecureStorage().getAccessToken();
    String token = '';
    return token;
  }
}
