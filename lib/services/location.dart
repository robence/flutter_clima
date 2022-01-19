import 'package:flutter_clima/services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

final apiKey = dotenv.env['API_KEY'];
const apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

class Location {
  double? latitude;
  double? longitude;

  Future getLocationData() async {
    try {
      final Position? position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position?.latitude ?? 35;
      longitude = position?.longitude ?? 139;
    } catch (e) {
      latitude = 35;
      longitude = 139;
    }

    final url = Uri.parse(
        '$apiUrl?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');
    final networkHelper = NetworkHelper(url);

    final decodedData = await networkHelper.getData();

    return decodedData;
  }
}
