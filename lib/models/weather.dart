import 'package:weather_report_bloc/models/hour.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double maxTemp;
  final double minTemp;
  final List<Hour> hours;

  Weather({
    required this.maxTemp,
    required this.minTemp,
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
    required this.hours,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    List<Hour> hours = (json['forecast']['forecastday'][0]['hour'] as List)
        .map((i) => Hour.fromJson(i))
        .toList();
    return Weather(
      cityName: json['location']['name'],
      mainCondition: json['current']['condition']['text'],
      temperature: json['current']['temp_c'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      hours: hours,
    );
  }
}
