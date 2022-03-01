import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';

const key = 'e3da0dbf133b9560f178270040d27620';
const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    ClimaLocation climaLocation = ClimaLocation();
    await climaLocation.getLocation();

    NetworkHelper helper = NetworkHelper(
        url:
            '$baseUrl?lat=${climaLocation.lat}&lon=${climaLocation.lon}&appid=$key&units=metric');

    var weatherData = await helper.getData();

    return weatherData;
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
