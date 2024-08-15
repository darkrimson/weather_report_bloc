import 'package:weather_report_bloc/models/condition.dart';

class Day {
  final double maxTempC;
  final double minTempC;
  final Condition condition;

  Day({
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}
