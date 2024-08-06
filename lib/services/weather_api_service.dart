import 'package:dio/dio.dart';
import 'package:weather_report_bloc/models/weather.dart';

class WeatherApiService {
  final _dio = Dio();
  static const _BASE_URL = 'http://api.weatherapi.com/v1/forecast.json';
  static const _API_KEY = 'a3d7069fc3c4407f912120532231012';

  Future<Weather> getWeather(String city) async {
    final response = await _dio.get(_BASE_URL, queryParameters: {
      'q': city,
      'key': _API_KEY,
    });
    return Weather.fromJson(response.data);
  }
}
