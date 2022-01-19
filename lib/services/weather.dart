import 'package:flutter_clima/services/location.dart';
import 'package:flutter_clima/services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKey = dotenv.env['API_KEY'];
const apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  getLocationWeather() async {
    final location = Location();
    await location.getCurrentLocation();

    final url = Uri.parse(
        '$apiUrl?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');
    final networkHelper = NetworkHelper(url);

    final decodedData = await networkHelper.getData();
    return decodedData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
