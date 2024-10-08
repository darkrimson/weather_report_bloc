import 'package:weather_report_bloc/models/condition.dart';

class Hour {
  final String time;
  final double tempC;
  final Condition condition;
  Hour({
    required this.time,
    required this.tempC,
    required this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temp_c': tempC,
      'condition': condition.toJson(),
    };
  }

  factory Hour.fromJson(Map<String, dynamic> json) {
    String formattedTime = json['time'].split(' ')[1];
    return Hour(
      time: formattedTime,
      tempC: json['temp_c'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}
