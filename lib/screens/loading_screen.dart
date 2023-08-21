import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/location_screen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
    try{

      var decodedData = await WeatherModel().getLocationWeather();
      print('Data--------------------------------->$decodedData');
      double temp = decodedData['main']['temp'];
      String city = decodedData['name'];
      print("temperature : $temp");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return LocationScreen(locationScreenData: LocationScreenData(temp, city));
      }), (route) => false);
// temp      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
//         return LocationScreen(LocationScreenData(temp, city));
//       }), (route) => false)
      // Navigator.pushNamedAndRemoveUntil(context, '/location_screen',
      //     (Route<dynamic> route)=>false,
      //     arguments: LocationScreenData(temp, city)
      // );
    }catch(e){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return LocationScreen(locationScreenData: null);
      }), (route) => false);

    }

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
