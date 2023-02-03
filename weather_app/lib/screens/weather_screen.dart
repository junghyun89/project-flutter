import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:weather_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic parsedWeatherData;
  final dynamic parsedAirData;
  const WeatherScreen({
    super.key,
    required this.parsedWeatherData,
    required this.parsedAirData,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String cityName;
  late int tempInt;
  late String description;
  late Widget weatherIcon;
  late Widget airIcon;
  late Widget airStatus;
  double fineDust = 0;
  double ultraFineDust = 0;
  Model model = Model();
  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    updateWeatherData(widget.parsedWeatherData);
    updateAirData(widget.parsedAirData);
  }

  updateWeatherData(dynamic weatherData) {
    double tempDouble = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];

    cityName = weatherData['name'];
    description = weatherData['weather'][0]['description'];
    tempInt = tempDouble.round();
    weatherIcon = model.getWeatherIcon(condition);
  }

  updateAirData(dynamic airData) {
    int index = airData['list'][0]['main']['aqi'];

    airIcon = model.getAirIcon(index);
    airStatus = model.getAirCondition(index);
    ultraFineDust = airData['list'][0]['components']['pm2_5'];
    fineDust = airData['list'][0]['components']['pm10'];
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat('h:mm a').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.location_searching),
            iconSize: 30,
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 150,
                              ),
                              Text(
                                cityName,
                                style: GoogleFonts.ubuntu(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  TimerBuilder.periodic(
                                    const Duration(minutes: 1),
                                    builder: (context) {
                                      return Text(
                                        getSystemTime(),
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    DateFormat('  EEEE').format(date),
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    DateFormat(' d MMM, yyy').format(date),
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$tempInt\u2103',
                                style: GoogleFonts.ubuntu(
                                    fontSize: 85.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              Row(
                                children: [
                                  weatherIcon,
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    description,
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Divider(
                          height: 15.0,
                          thickness: 2.0,
                          color: Colors.white30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'AQI(대기질지수)',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                airIcon,
                                const SizedBox(
                                  height: 10.0,
                                ),
                                airStatus,
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '미세먼지',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '$fineDust',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'μg/m3',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '초미세먼지',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '$ultraFineDust',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'μg/m3',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
