import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report_bloc/models/weather.dart';
import '../../blocs/weather_bloc.dart';
import '../widgets/widgets.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoaded) {
                return BackgroundImage(pageIndex: _currentPageIndex);
              }
              return const SizedBox
                  .shrink(); // пустой контейнер, если погода не загружена
            },
          ),
          _WeatherContent(
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _WeatherContent extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const _WeatherContent({
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeatherLoaded) {
          return PageView.builder(
            controller: pageController,
            itemCount: state.weathers.length,
            onPageChanged: onPageChanged,
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
          return Center(child: Text(state.message));
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
        const SizedBox(height: 20),
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
        const SizedBox(height: 15)
      ],
    );
  }
}
