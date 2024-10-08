import 'package:weather_report_bloc/models/astro.dart';
import 'package:weather_report_bloc/models/day.dart';
import 'package:weather_report_bloc/models/hour.dart';

class ForecastDay {
  final String date;
  final Day day;
  final List<Hour> hour;
  final Astro astro;

  ForecastDay(
      {required this.date,
      required this.day,
      required this.hour,
      required this.astro});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['day'] = day.toJson();
    data['hour'] = hour.map((v) => v.toJson()).toList();
    data['astro'] = astro.toJson();
    return data;
  }

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    List<Hour> hours =
        (json['hour'] as List).map((i) => Hour.fromJson(i)).toList();
    return ForecastDay(
      hour: hours,
      date: json['date'],
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
    );
  }
}
