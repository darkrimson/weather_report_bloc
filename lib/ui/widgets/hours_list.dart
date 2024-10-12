import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_report_bloc/models/weather.dart';
import 'package:weather_report_bloc/ui/widgets/widgets.dart';

class HoursList extends StatelessWidget {
  final Weather weather;
  const HoursList({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    final hours = weather.forecast.forecastDay[0].hour;
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
              text: "Forecast for 24 hours",
              '',
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                // Фильтруем список, оставляем только часы, которые равны или позже текущего времени
                itemCount: hours
                    .where((hour) {
                      // Предполагаем, что hour.time - это строка в формате "HH:mm"
                      String timeString = hour.time; // Например, "14:30"
                      DateTime now = DateTime.now();

                      // Парсим строку времени в формат "HH:mm"
                      DateFormat timeFormat = DateFormat("HH:mm");
                      DateTime parsedTime = timeFormat.parse(timeString);

                      // Создаем объект DateTime с текущей датой, но с парсированным временем
                      DateTime hourTime = DateTime(now.year, now.month, now.day,
                          parsedTime.hour, parsedTime.minute);

                      // Фильтрация: оставляем только будущие или текущие часы
                      return hourTime.isAfter(now) ||
                          hourTime.isAtSameMomentAs(now);
                    })
                    .toList()
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  // Используем отфильтрованный список для отображения
                  var filteredHours = hours.where((hour) {
                    String timeString = hour.time;
                    DateTime now = DateTime.now();

                    // Парсим строку времени в формат "HH:mm"
                    DateFormat timeFormat = DateFormat("HH:mm");
                    DateTime parsedTime = timeFormat.parse(timeString);

                    // Создаем объект DateTime с текущей датой и временем
                    DateTime hourTime = DateTime(now.year, now.month, now.day,
                        parsedTime.hour, parsedTime.minute);

                    return hourTime.isAfter(now) ||
                        hourTime.isAtSameMomentAs(now);
                  }).toList();

                  var hour = filteredHours[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HourCard(
                      hour: hour,
                      color: Colors.white,
                    ),
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
