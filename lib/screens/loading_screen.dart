// ignore_for_file: unrelated_type_equality_checks

import 'package:clima_app/screens/location_screen.dart';
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
    getLocationData();
    super.initState();
  }

  Future<dynamic> getLocationData() async {
  
   WeatherModel weatherModel = WeatherModel();
  var weatherData =  await weatherModel.getLocationWeather();   

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: SpinKitDoubleBounce(size: 50, color: Colors.blue),
    ));
  }
}
