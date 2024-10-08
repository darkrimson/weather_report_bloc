import 'package:weather_report_bloc/models/condition.dart';

class Day {
  final double maxTempC;
  final double minTempC;
  final Condition condition;
  final int chanceOfRain;

  Day({
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
    required this.chanceOfRain,
  });

  Map<String, dynamic> toJson() {
    return {
      'maxtemp_c': maxTempC,
      'mintemp_c': minTempC,
      'condition': condition.toJson(),
      'daily_chance_of_rain': chanceOfRain,
    };
  }

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      condition: Condition.fromJson(json['condition']),
      chanceOfRain: json['daily_chance_of_rain'],
    );
  }
}
