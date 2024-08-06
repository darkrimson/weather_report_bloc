// lib/views/weather_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  final _cityController = TextEditingController();

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'City Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final cityName = _cityController.text;
              if (cityName.isNotEmpty) {
                context.read<WeatherBloc>().add(GetWeatherEvent(cityName));
              }
            },
            child: const Text('Get Weather'),
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return const Text('Enter a city name');
              } else if (state is WeatherLoading) {
                return const CircularProgressIndicator();
              } else if (state is WeatherLoaded) {
                return Column(
                  children: [
                    Text('City: ${state.weather.cityName}'),
                    Text('Temperature: ${state.weather.temperature}°C'),
                    Text('Description: ${state.weather.mainCondition}'),
                  ],
                );
              } else if (state is WeatherError) {
                return Text(state.message);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
