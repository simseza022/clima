import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Location location;
  String apiKey = "f7731327e7e07896796f97e5fc8794c6";

  /*-----Lifecycle methods for a stateful widget------
  * 1. initState() -> gets called first when the widget is created and added into the widget tree.
  * 2. build() -> gets called everytime when our stateful widget gets built or rebuilt(via state method)
  * 3. deactivate() -> gets called everytime when our stateful widget gets popped off the widget tree.
  * */
  @override
  void initState() {
    super.initState();
    location = Location();
    getLocation();
  }
  void getLocation() async{
      Position position = await location.determinePosition();
      print('lat: ${location.latitude}, long: ${location.longitude}');

  }
  Future<void> getData() async {
    http.Response response =  await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=-26.3&lon=-26.3&appid=f7731327e7e07896796f97e5fc8794c6'));
    if(response.statusCode == 200){
      String data = response.body;
      print(data);
    }
    else{
      print(response.statusCode);
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
