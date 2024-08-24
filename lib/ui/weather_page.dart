import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_bloc.dart';
import 'widgets/widgets.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late ScrollController _scrollController;
  String _appBarTitle = '';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final offset = _scrollController.offset;
        if (offset > 200) {
          final newTitle = BlocProvider.of<WeatherBloc>(context).state
                  is WeatherLoaded
              ? (BlocProvider.of<WeatherBloc>(context).state as WeatherLoaded)
                  .weather
                  .location
                  .name
              : '';
          if (_appBarTitle != newTitle) {
            setState(() {
              _appBarTitle = newTitle;
            });
          }
        } else {
          if (_appBarTitle != '') {
            setState(() {
              _appBarTitle = '';
            });
          }
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          _WeatherContent(
              scrollController: _scrollController, appBarTitle: _appBarTitle),
        ],
      ),
    );
  }
}

class _WeatherContent extends StatelessWidget {
  final ScrollController scrollController;
  final String appBarTitle;

  const _WeatherContent({
    required this.scrollController,
    required this.appBarTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarWidget(
        title: appBarTitle,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
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
        LocationText(text: state.weather.location.name),
        TempText(text: '${state.weather.current.tempC.round()}°'),
        ConditionTempsRow(
          condition: '${state.weather.current.condition.text} ',
          maxTemp: state.weather.forecast.forecastDay[0].day.maxTempC,
          minTemp: state.weather.forecast.forecastDay[0].day.minTempC,
        ),
        const SizedBox(height: 50),
        _HoursList(state),
        const SizedBox(height: 15),
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

class _HoursList extends StatelessWidget {
  final WeatherLoaded state;
  const _HoursList(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final hours = state.weather.forecast.forecastDay[0].hour;
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 44, 108, 160).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const HeaderForecastRow(
              text: "Прогноз на 24 ч",
              '',
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: hours.length,
                itemBuilder: (BuildContext context, int index) {
                  var hour = hours[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HourCard(hour: hour),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
