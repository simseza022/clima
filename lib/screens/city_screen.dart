import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

import '../utilities/location_screen_data.dart';
import 'location_screen.dart';

class CityScreen extends StatefulWidget {

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late List<dynamic> data;
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 40.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: null,
              ),
              SizedBox(
                width: 260,
                child: TextField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: '',
                    hintText: "City Name",
                    filled: true,
                    fillColor: Colors.white24

                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: null,
              ),
              TextButton(
                onPressed: () {
                  String city = cityController.text;
                  WeatherModel().getCityWeather(city).then((decodedData) => {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                      return LocationScreen(locationScreenData: LocationScreenData(decodedData['main']['temp'] as double, decodedData['name'] as String));
                    }), (route) => false)
                    // print(value)
                  });
                  // print(city);
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
