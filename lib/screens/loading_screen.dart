import 'dart:convert';

import 'package:clima_app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

const key = 'e3da0dbf133b9560f178270040d27620';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? longitude;
  double? latitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    ClimaLocation climaLocation = ClimaLocation();
    await climaLocation.getLocation();

    latitude = climaLocation.lat;
    longitude = climaLocation.lon;

    debugPrint(climaLocation.lat.toString());
    debugPrint(climaLocation.lon.toString());

    getWeather();
  }

  void getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$key&units=metric'));

    if (response.statusCode == 200) {
      String name = jsonDecode(response.body)['name'];
      int condition = jsonDecode(response.body)['weather'][0]['id'];
      double temperature = jsonDecode(response.body)['main']['temp'];

      debugPrint(response.body);

      debugPrint(name);
      debugPrint(condition.toString());
      debugPrint(temperature.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Get the current location
            getLocation();
          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}
