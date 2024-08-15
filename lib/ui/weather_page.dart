// lib/views/weather_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_bloc.dart';

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
                  Text(
                    state.weather.location.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${state.weather.current.tempC.round()}°',
                    style: const TextStyle(fontSize: 150, height: 1.1),
                  ),
                  Row(
                    children: [
                      Text(
                        '${state.weather.current.condition} ',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${state.weather.forecast.forecastDay[0].day.maxTempC.round()}° / ${state.weather.forecast.forecastDay[0].day.minTempC.round()}°',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
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
                          const Row(
                            children: [
                              Icon(Icons.calendar_today_outlined),
                              Expanded(
                                child: Text("Прогноз на 5 дней"),
                              ),
                              Text("Подробнее"),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(
                                child: Text("Сегодня"),
                              ),
                              const Expanded(
                                  child: Icon(Icons.calendar_today_outlined)),
                              Text(
                                  '${state.weather.forecast.forecastDay[0].day.maxTempC.round()}° / ${state.weather.forecast.forecastDay[0].day.minTempC.round()}°',
                                  style: const TextStyle(fontSize: 18))
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.grey[300]!),
                                minimumSize: WidgetStateProperty.all<Size>(
                                  const Size(300, 50),
                                )),
                            onPressed: () {},
                            child: const Text("Прогноз на 5 дней"),
                          )
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
