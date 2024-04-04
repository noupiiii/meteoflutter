import 'package:meteoflutter/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Added this line

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final url = Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric');

    final response = await http.get(url);
    print(url);
    print(response.body);

    if (response.statusCode == 200) {
      return Weather.formJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}