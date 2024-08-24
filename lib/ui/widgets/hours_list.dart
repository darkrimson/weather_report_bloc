import 'package:flutter/material.dart';
import 'package:weather_report_bloc/blocs/weather_bloc.dart';
import 'package:weather_report_bloc/ui/widgets/widgets.dart';

class HoursList extends StatelessWidget {
  final WeatherLoaded state;
  const HoursList(this.state, {super.key});

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
