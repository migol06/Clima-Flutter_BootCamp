import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';

const key = 'e3da0dbf133b9560f178270040d27620';
const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String name) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$baseUrl?q=$name&appid=$key&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
