import 'dart:convert';

import 'package:flutter_weather/forecast.dart';
import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;

const API_KEY = '146b0902681844c66dd977945d56ab6e';
const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather?';
const API_KEY_QUERY = '&appid=$API_KEY';

Future<Forecast> getWeather({@required String zip}) async {
  var url = '${BASE_URL}zip=$zip,ph&units=metric${API_KEY_QUERY}';
  var response = await http.get(url);
  var jsonResponse = json.decode(response.body);
  return Forecast.fromJson(jsonResponse);
}