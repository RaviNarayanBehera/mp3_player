import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService
{
  Future<Map<String,dynamic>> fetchSongs()
  async {
    String api = "http://saavn.dev/api/search/songs?query=arijit";

    Uri uri = Uri.parse(api);
    http.get(uri);
    Response response = await http.get(uri);
    if(response.statusCode==200)
      {
        String json = response.body;
        Map<String,dynamic> songs = jsonDecode(json);
        return songs;
      }
    return {};

  }
}