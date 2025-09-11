import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_web_opensource/models/weather_model.dart';

class WeatherService {
  final String apiKey = '0d98254c13c01ec880ed53a1a20871d9';

  Future<Weather> getWeatherByCity(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=vi';
    return _fetchWeatherData(url);
  }

  Future<Weather> getWeatherByCoordinates(double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=vi';
    return _fetchWeatherData(url);
  }

  Future<Weather> _fetchWeatherData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception(
          'Lỗi: ${response.statusCode} - Không tìm thấy dữ liệu thời tiết');
    }
  }
}
