import 'package:clima_app/services/weather.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late double temprature;
  late int temp;
  late String weatherIcon;
  late String weatherMessage;
  late String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherdata) {
   

    setState(() {

       if (weatherdata == null) {
         temprature = 0;
          temp = 0;
          weatherIcon = 'Error';
          weatherMessage = 'Unable to get weather data';
          cityName = '';
          return;
      
    }
      temprature = weatherdata['main']['temp'];
      temp = temprature.toInt();
      weatherMessage = weather.getMessage(temp);

      var condition = weatherdata['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherdata['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: const Icon(
                  //     Icons.location_city,
                  //     size: 50.0,
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
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
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.left,
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
