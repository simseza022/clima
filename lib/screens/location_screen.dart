import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/location_screen_data.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

import '../services/networking.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String apiKey = "f7731327e7e07896796f97e5fc8794c6";
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
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
            child: args == null
                ? locationDisabledError()
                : locationServicesEnabled(args as LocationScreenData)),
      ),
    );
  }

  Widget locationDisabledError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          IconData(
            0xe237,
            fontFamily: 'MaterialIcons',
          ),
          size: 100,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Please enable location services to use this app"),
        const SizedBox(
          height: 40,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/loading_screen");
            },
            child: const Text(
              "ENABLE",
              style: TextStyle(color: Colors.blueAccent, fontSize: 20),
            ))
      ],
    );
  }

  Column locationServicesEnabled(LocationScreenData data) {
    int tempInDegrees = (data.temperature - 273.15).round();
    WeatherModel weatherModel = WeatherModel();
    String weatherIcon = weatherModel.getWeatherIcon(data.temperature.round());
    String weatherMessage = weatherModel.getMessage(tempInDegrees);
    String city = data.city;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.near_me,
                size: 50.0,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.location_city,
                size: 50.0,
              ),
            ),
          ],
        ),
        Text(
          city,
          style: kMessageTextStyle,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Center(
            child: Row(
              children: <Widget>[
                Text(
                  '$tempInDegrees°',
                  style: kTempTextStyle,
                ),
                Text(
                  weatherIcon,
                  style: kConditionTextStyle,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text(
            "$weatherMessage!",
            textAlign: TextAlign.left,
            style: kMessageTextStyle,
          ),
        ),
      ],
    );
  }
  void getLocation() async {
    try{
      Location location = Location();
      var position = await location.determinePosition();
      String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey';
      NetworkHelper networkHelper = NetworkHelper(url);
      var decodedData = await networkHelper.getData();
      print(decodedData);
      double temp = decodedData['main']['temp'];
      String city = decodedData['name'];
      print("temperature : $temp");


    }catch(e){
      Navigator.pushNamed(context, '/location_screen',);
    }
  }

}
