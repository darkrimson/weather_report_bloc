import 'package:flutter/material.dart';
import 'package:weather_report_bloc/models/weather.dart';

import 'widgets.dart';

class ForecastDetails extends StatelessWidget {
  final Weather weather;

  const ForecastDetails({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 44, 108, 160).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const HeaderForecastRow(text: "Forecast for 3 days", 'More'),
            const SizedBox(height: 20),
            ForecastDayRow(
              day: weather.forecast.forecastDay[0].day,
              date: weather.forecast.forecastDay[0].date,
            ),
            const SizedBox(height: 10),
            ForecastDayRow(
              day: weather.forecast.forecastDay[1].day,
              date: weather.forecast.forecastDay[1].date,
            ),
            const SizedBox(height: 10),
            ForecastDayRow(
              day: weather.forecast.forecastDay[2].day,
              date: weather.forecast.forecastDay[2].date,
            ),
            const SizedBox(height: 20),
            const ForecastButton(),
          ],
        ),
      ),
    );
  }
}
