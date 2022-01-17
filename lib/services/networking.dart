import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  Uri url;

  NetworkHelper(this.url);

  Future getData() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = response.body;
      final decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
