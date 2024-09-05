import 'package:flutter/material.dart';
import 'package:weather_report_bloc/blocs/weather_bloc.dart';

import 'widgets.dart';

class ForecastSummary extends StatelessWidget {
  final WeatherLoaded state;

  const ForecastSummary({
    super.key,
    required this.state,
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
                current: state.weather.current,
              ),
              const SizedBox(height: 10),
              InfoSun(astro: state.weather.forecast.forecastDay[0].astro),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          DetailsColumn(
            current: state.weather.current,
            day: state.weather.forecast.forecastDay[0].day,
          ),
        ],
      ),
    );
  }
}
