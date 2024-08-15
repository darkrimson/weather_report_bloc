import 'package:dio/dio.dart';
import 'package:weather_report_bloc/exceptions/weather_exception.dart';
import 'package:weather_report_bloc/models/weather.dart';
import 'package:weather_report_bloc/exceptions/dio_error_handler.dart';
import 'package:weather_report_bloc/services/dio_client.dart';
import 'package:weather_report_bloc/services/get_location.dart';

class WeatherApiService {
  final Dio _dio = DioClient.createDio();

  Future<Weather> getWeather(String city) async {
    try {
      final response = await _dio.get('forecast.json', queryParameters: {
        'q': city,
      });
      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      } else {
        throw WeatherException('Failed to load weather');
      }
    } on DioException catch (e) {
      throw WeatherException(DioErrorHandler.handleError(e));
    }
  }

  Future<Weather> getWeatherByLocation() async {
    final city = await GetLocation().getCurrentLocation();
    try {
      final response = await _dio.get('forecast.json', queryParameters: {
        'q': city,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      } else {
        throw WeatherException('Failed to load weather');
      }
    } on DioException catch (e) {
      throw WeatherException(DioErrorHandler.handleError(e));
    }
  }
}
