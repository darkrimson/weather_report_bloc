import 'package:weather_report_bloc/models/current.dart';
import 'package:weather_report_bloc/models/forecast.dart';
import 'package:weather_report_bloc/models/location.dart';

class Weather {
  final Location location;
  final Current current;
  final Forecast forecast;

  Weather(
      {required this.location, required this.current, required this.forecast});

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'current': current.toJson(),
      'forecast': forecast.toJson(),
    };
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}
