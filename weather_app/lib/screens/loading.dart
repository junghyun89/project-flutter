import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/helper/my_location.dart';
import 'package:weather_app/helper/network.dart';
import 'package:weather_app/helper/permission_status.dart';
import 'package:weather_app/screens/weather_screen.dart';

const apiKey = '15158171cb4853122d769e6733803088';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double myLatitude;
  late double myLongitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    PermissionStatus permissionStatus = PermissionStatus();
    permissionStatus.checkStatus();

    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    myLatitude = myLocation.latitude;
    myLongitude = myLocation.longitude;

    var weatherData = await getWeatherData();
    var airData = await getAirData();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherScreen(
            parsedWeatherData: weatherData,
            parsedAirData: airData,
          );
        },
      ),
    );
  }

  Future<dynamic> getWeatherData() async {
    Network network = Network(
      'https://api.openweathermap.org/data/2.5/weather?lat=$myLatitude&lon=$myLongitude&appid=$apiKey&units=metric',
    );
    var weatherData = await network.getJsonData();
    print(weatherData);
    return weatherData;
  }

  Future<dynamic> getAirData() async {
    Network network = Network(
      'https://api.openweathermap.org/data/2.5/air_pollution?lat=$myLatitude&lon=$myLongitude&appid=$apiKey',
    );
    var airData = await network.getJsonData();
    print(airData);
    return airData;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black38,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
