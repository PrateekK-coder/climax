import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:climax/utilities/constants.dart';
import 'package:climax/services/weather.dart';
import 'package:flutter/services.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
    print(temperature);
  }

  void updateUi(dynamic weatherdata) {
    setState(() {
      if (weatherdata==null){
          showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('It looks like your location is disabled'),
              content: Text('or Server problem has occured :('),
              actions: <Widget>[
                TextButton(
                  child: Text('Exit'),
                  onPressed: () {
                    SystemNavigator.pop();
                    
                  },
                ),
              ],
            );
          }
        
        );
      }
    });
      
      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherdata['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature);
      cityName = weatherdata['name'];
    
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData= await weatherModel.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.my_location_sharp,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//  double temperature = decodedata['main']['temp'];
//     int condition = decodedata['weather'][0]['id'];
//     String cityName = decodedata['name'];
