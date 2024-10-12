import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
      backgroundColor: Colors.blue.shade200,
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
          return Center(
              child: Image.asset('assets/icons/animate.gif',
                  width: 100, height: 100));
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
                      state: state,
                      weather: weather,
                      pageController: pageController,
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is WeatherError) {
          return _errorPage(state, context);
        }
        return Container();
      },
    );
  }
}

class _WeatherDetails extends StatelessWidget {
  final Weather weather;
  final PageController pageController;
  final WeatherLoaded state;

  const _WeatherDetails(
      {required this.weather,
      required this.pageController,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmoothPageIndicator(
          controller: pageController,
          count: state.weathers.length,
        ),
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

Center _errorPage(WeatherError state, BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/icons/error.webp',
            width: 200,
            height: 200,
          ),
        ),
        const SizedBox(height: 20),
        Text(state.message,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        const Text('Проверьте интернет и GPS',
            style: TextStyle(fontSize: 18, color: Colors.black)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            context.read<WeatherBloc>().add(GetWeatherByLocationEvent());
          },
          child: const Text(
            'Повторить',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
