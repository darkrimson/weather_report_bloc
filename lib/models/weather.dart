import 'package:weather_report_bloc/models/current.dart';
import 'package:weather_report_bloc/models/forecast.dart';
import 'package:weather_report_bloc/models/location.dart';

class Weather {
  final Location location;
  final Current current;
  final Forecast forecast;

  Weather(
      {required this.location, required this.current, required this.forecast});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}
