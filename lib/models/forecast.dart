import 'package:weather_report_bloc/models/forecast_day.dart';

class Forecast {
  final List<ForecastDay> forecastDay;

  Forecast({required this.forecastDay});

  Map<String, dynamic> toJson() {
    return {
      'forecastday': forecastDay,
    };
  }

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final list = json['forecastday'] as List;
    List<ForecastDay> forecastList =
        list.map((i) => ForecastDay.fromJson(i)).toList();
    return Forecast(forecastDay: forecastList);
  }
}
