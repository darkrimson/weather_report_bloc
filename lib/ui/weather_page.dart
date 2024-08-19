import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report_bloc/ui/widgets/app_bar.dart';
import '../blocs/weather_bloc.dart';
import 'widgets/widgets.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _BackgroundImage(),
          _WeatherContent(),
        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  String _getBackgroundImage(WeatherLoaded state) {
    final conditionToImage = {
      'Clear': 'assets/photo.jpg',
      'Rain': 'assets/rainy.gif',
      'Clouds': 'assets/cloudy.gif',
    };

    return conditionToImage[state.weather.current.condition.text] ??
        'assets/default_background.png';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        String backgroundImage = '';

        if (state is WeatherLoaded) {
          backgroundImage = _getBackgroundImage(state);
        }

        return backgroundImage.isNotEmpty
            ? Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : Container();
      },
    );
  }
}

class _WeatherContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return _WeatherDetails(state);
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

class _WeatherDetails extends StatelessWidget {
  final WeatherLoaded state;

  const _WeatherDetails(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        LocationText(text: state.weather.location.name),
        TempText(text: '${state.weather.current.tempC.round()}°'),
        ConditionTempsRow(
          condition: '${state.weather.current.condition.text} ',
          maxTemp: state.weather.forecast.forecastDay[0].day.maxTempC,
          minTemp: state.weather.forecast.forecastDay[0].day.minTempC,
        ),
        const SizedBox(height: 50),
        _ForecastDetails(state),
      ],
    );
  }
}

class _ForecastDetails extends StatelessWidget {
  final WeatherLoaded state;

  const _ForecastDetails(this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              maxTemp: state.weather.forecast.forecastDay[0].day.maxTempC,
              minTemp: state.weather.forecast.forecastDay[0].day.minTempC,
            ),
            const SizedBox(height: 10),
            ForecastDayRow(
              dayLabel: 'Завтра',
              maxTemp: state.weather.forecast.forecastDay[1].day.maxTempC,
              minTemp: state.weather.forecast.forecastDay[1].day.minTempC,
            ),
            const SizedBox(height: 10),
            ForecastDayRow(
              dayLabel: 'Послезавтра',
              maxTemp: state.weather.forecast.forecastDay[2].day.maxTempC,
              minTemp: state.weather.forecast.forecastDay[2].day.minTempC,
            ),
            const SizedBox(height: 20),
            const ForecastButton(),
          ],
        ),
      ),
    );
  }
}
