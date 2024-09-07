import 'package:flutter/material.dart';
import 'package:weather_report_bloc/models/weather.dart';

import 'widgets.dart';

class ForecastSummary extends StatelessWidget {
  final Weather weather;

  const ForecastSummary({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoWind(
                current: weather.current,
              ),
              const SizedBox(height: 10),
              InfoSun(astro: weather.forecast.forecastDay[0].astro),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          DetailsColumn(
            current: weather.current,
            day: weather.forecast.forecastDay[0].day,
          ),
        ],
      ),
    );
  }
}
