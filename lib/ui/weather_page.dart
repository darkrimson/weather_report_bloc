// lib/views/weather_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_bloc.dart';
import 'widgets/widgets.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Погода'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<WeatherBloc>().add(GetWeatherByLocationEvent());
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return const Text('Enter a city name');
            } else if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  LocationText(
                    text: state.weather.location.name,
                  ),
                  TempText(text: '${state.weather.current.tempC.round()}°'),
                  ConditionTempsRow(
                    conditionText: '${state.weather.current.condition.text} ',
                    maxTempText:
                        '${state.weather.forecast.forecastDay[0].day.maxTempC.round()}',
                    minTempText:
                        '${state.weather.forecast.forecastDay[0].day.minTempC.round()}',
                  ),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const HeaderForecastRow(),
                          const SizedBox(height: 20),
                          ForecastDayRow(
                              dayLabel: 'Сегодня',
                              maxTemp: state
                                  .weather.forecast.forecastDay[0].day.maxTempC,
                              minTemp: state.weather.forecast.forecastDay[0].day
                                  .minTempC),
                          const SizedBox(height: 10),
                          ForecastDayRow(
                              dayLabel: 'Завтра',
                              maxTemp: state
                                  .weather.forecast.forecastDay[1].day.maxTempC,
                              minTemp: state.weather.forecast.forecastDay[1].day
                                  .minTempC),
                          const SizedBox(height: 10),
                          ForecastDayRow(
                              dayLabel: 'Послезавтра',
                              maxTemp: state
                                  .weather.forecast.forecastDay[2].day.maxTempC,
                              minTemp: state.weather.forecast.forecastDay[2].day
                                  .minTempC),
                          const SizedBox(height: 20),
                          const ForecastButton()
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is WeatherError) {
              return Text(state.message);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
