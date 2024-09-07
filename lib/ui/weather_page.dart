import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report_bloc/models/weather.dart';
import '../blocs/weather_bloc.dart';
import 'widgets/widgets.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BackgroundImage(),
          _WeatherContent(),
        ],
      ),
    );
  }
}

class _WeatherContent extends StatelessWidget {
  const _WeatherContent();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeatherLoaded) {
          return PageView.builder(
            itemCount: state.weathers.length,
            itemBuilder: (context, index) {
              final weather = state.weathers[index];
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBarWidget(
                  title: weather.location.name,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _WeatherDetails(
                      weather: weather,
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is WeatherError) {
          return Text(state.message);
        }
        return Container();
      },
    );
  }
}

class _WeatherDetails extends StatelessWidget {
  final Weather weather;

  const _WeatherDetails({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TempText(text: '${weather.current.tempC.round()}°'),
        ConditionTempsRow(
          day: weather.forecast.forecastDay[0].day,
        ),
        const SizedBox(height: 30),
        ForecastDetails(weather: weather),
        const SizedBox(height: 15),
        HoursList(
          weather: weather,
        ),
        const SizedBox(height: 15),
        ForecastSummary(weather: weather),
      ],
    );
  }
}
