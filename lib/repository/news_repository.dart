import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class NewsRepositoryInterface {
  Future<dynamic> fetchAlbum();
}

class NewsRepository implements NewsRepositoryInterface {
  Future<List<dynamic>> fetchAlbum() async {
    final _response = await http
        .get('https://gb-mobile-app-teste.s3.amazonaws.com/data.json');
    final _decodedData = json.decode(_response.body)['news'];
    if (_response.statusCode == 200) {
      return _decodedData;
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
