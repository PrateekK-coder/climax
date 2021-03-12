import 'package:flutter/material.dart';
import 'package:climax/services/location.dart';
import 'package:climax/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCUrrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=95de81dabf1be02727437790fb6a9191');
    var weatherData = await networkHelper.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
