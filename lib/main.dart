import 'package:flutter_weather/api.dart';
import 'package:flutter_weather/forecast.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Forecast forecast;

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  void retrieveData() async {
    Forecast forecast = await getWeather(zip: "6000");
    setState(() {
      this.forecast = forecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.6, 0.8, 1.0],
          colors: [
            Colors.blue[700],
            Colors.blue[500],
            Colors.blue[300],
          ],
        ),
      ),
      child: Center(
        child: forecast == null
            ? CircularProgressIndicator()
            : WeatherInfo(forecast: forecast),
      ),
    ));
  }
}

class WeatherInfo extends StatelessWidget {
  final Forecast forecast;

  const WeatherInfo({Key key, this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(forecast.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 50),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.network(
                'http://openweathermap.org/img/w/${forecast.weather[0].icon}.png'),
          ),
          Text(forecast.weather[0].main,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
