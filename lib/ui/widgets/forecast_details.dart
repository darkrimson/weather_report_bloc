import 'package:flutter/material.dart';
import 'package:weather_report_bloc/blocs/weather_bloc.dart';

import 'widgets.dart';

class ForecastDetails extends StatelessWidget {
  final WeatherLoaded state;

  const ForecastDetails(this.state, {super.key});

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
            const HeaderForecastRow(text: "Прогноз на 5 дней", 'Подробнее'),
            const SizedBox(height: 20),
            ForecastDayRow(
              dayLabel: 'Сегодня',
              maxTemp: state.weather.forecast.forecastDay[0].day.maxTempC,
              minTemp: state.weather.forecast.forecastDay[0].day.minTempC,
              iconUrl: state.weather.forecast.forecastDay[0].day.condition.icon,
            ),
            const SizedBox(height: 10),
            ForecastDayRow(
              dayLabel: 'Завтра',
              maxTemp: state.weather.forecast.forecastDay[1].day.maxTempC,
              minTemp: state.weather.forecast.forecastDay[1].day.minTempC,
              iconUrl: state.weather.forecast.forecastDay[1].day.condition.icon,
            ),
            const SizedBox(height: 10),
            ForecastDayRow(
              dayLabel: 'Послезавтра',
              maxTemp: state.weather.forecast.forecastDay[2].day.maxTempC,
              minTemp: state.weather.forecast.forecastDay[2].day.minTempC,
              iconUrl: state.weather.forecast.forecastDay[2].day.condition.icon,
            ),
            const SizedBox(height: 20),
            const ForecastButton(),
          ],
        ),
      ),
    );
  }
}
