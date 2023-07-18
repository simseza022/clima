import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/location_screen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Location location = Location();
  String apiKey = "f7731327e7e07896796f97e5fc8794c6";
  /*-----Lifecycle methods for a stateful widget------
  * 1. initState() -> gets called first when the widget is created and added into the widget tree.
  * 2. build() -> gets called everytime when our stateful widget gets built or rebuilt(via state method)
  * 3. deactivate() -> gets called everytime when our stateful widget gets popped off the widget tree.
  * */
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    await location.determinePosition();
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    print(decodedData);
    double temp = decodedData['main']['temp'];s
    String city = decodedData['name'];
    print("temperature : $temp");

    Navigator.pushNamed(context, '/location_screen',
        arguments: LocationScreenData(temp, city)
    );
  }

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
    const spinkit2 = SpinKitWaveSpinner(
      color: Colors.blueAccent,
      waveColor: Colors.amberAccent,
      size: 70,
    );
    return const Scaffold(
      body: Center(child: spinkit2),
    );
  }
}
