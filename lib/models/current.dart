import 'package:weather_report_bloc/models/condition.dart';

class Current {
  final double tempC;
  final Condition condition;
  final double feelsLikeC;
  final double windKph;
  final int humidity;
  final double uv;
  final String windDir;

  Current({
    required this.tempC,
    required this.condition,
    required this.feelsLikeC,
    required this.windKph,
    required this.humidity,
    required this.uv,
    required this.windDir,
  });

  Map<String, dynamic> toJson() {
    return {
      'temp_c': tempC,
      'condition': condition.toJson(),
      'feelslike_c': feelsLikeC,
      'wind_kph': windKph,
      'humidity': humidity,
      'uv': uv,
      'wind_dir': windDir,
    };
  }

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'],
      condition: Condition.fromJson(json['condition']),
      feelsLikeC: json['feelslike_c'],
      windKph: json['wind_kph'],
      humidity: json['humidity'],
      uv: json['uv'],
      windDir: json['wind_dir'],
    );
  }
}
