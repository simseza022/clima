import 'package:clima/services/location.dart';
import 'package:geolocator/geolocator.dart';

import 'networking.dart';

String apiKey = "f7731327e7e07896796f97e5fc8794c6";
const String openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";
class WeatherModel {

  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.determinePosition();
    String url = '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url);
    return networkHelper.getData();

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
