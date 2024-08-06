import 'package:weather_report_bloc/models/weather.dart';
import 'package:weather_report_bloc/services/weather_api_service.dart';

class WeatherRepository {
  final WeatherApiService apiService = WeatherApiService();

  Future<Weather> fetchWeather(String city) async {
    return await apiService.getWeather(city);
  }
}
