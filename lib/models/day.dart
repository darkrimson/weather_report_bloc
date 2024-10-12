import 'package:weather_report_bloc/models/condition.dart';

class Day {
  final double maxTempC;
  final double minTempC;
  final double maxWind;
  final double uv;
  final int humidity;
  final Condition condition;
  final int chanceOfRain;

  Day({
    required this.uv,
    required this.humidity,
    required this.maxTempC,
    required this.minTempC,
    required this.maxWind,
    required this.condition,
    required this.chanceOfRain,
  });

  Map<String, dynamic> toJson() {
    return {
      'uv': uv,
      'maxtemp_c': maxTempC,
      'mintemp_c': minTempC,
      'condition': condition.toJson(),
      'daily_chance_of_rain': chanceOfRain,
      'maxwind_kph': maxWind,
      'avghumidity': humidity
    };
  }

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      uv: json['uv'],
      humidity: json['avghumidity'],
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      maxWind: json['maxwind_kph'],
      condition: Condition.fromJson(json['condition']),
      chanceOfRain: json['daily_chance_of_rain'],
    );
  }
}
