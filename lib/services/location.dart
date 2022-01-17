import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

final apiKey = dotenv.env['API_KEY'];
const apiUrl = 'https://samples.openweathermap.org/data/2.5/weather';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    latitude = position.latitude;
    longitude = position.longitude;
  }

  void getData() async {
    final lat = latitude ?? 35;
    final lon = longitude ?? 139;

    final url = Uri.parse('$apiUrl?lat=$lat&lon=$lon&appid=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = response.body;

      final decodedData = jsonDecode(data);

      final double temperature = decodedData["main"]['temp'];
      final String city = decodedData["name"];
      final int condition = decodedData["weather"][0]['id'];
    } else {
      print(response.statusCode);
    }
  }
}
