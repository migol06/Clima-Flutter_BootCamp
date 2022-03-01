import 'package:clima_app/screens/location_screen.dart';
import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';
import 'package:clima_app/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var wetherData = await WeatherModel().getLocationWeather();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  locationWeather: wetherData,
                )));

    // debugPrint(weatherData['main']['temp'].toString());
    // debugPrint(climaLocation.lat.toString());
    // debugPrint(climaLocation.lon.toString());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
