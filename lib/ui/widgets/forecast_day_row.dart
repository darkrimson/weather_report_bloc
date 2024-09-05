import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_report_bloc/models/day.dart';

class ForecastDayRow extends StatelessWidget {
  final Day day;
  final String date;

  const ForecastDayRow({super.key, required this.day, required this.date});

  String getWeekday(String date) {
    // Парсим строку с датой в формат DateTime
    DateTime dateTime = DateTime.parse(date);

    // Форматируем дату в день недели
    String weekday = DateFormat('EEEE', 'en').format(dateTime);

    return weekday;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            getWeekday(date.toString().substring(0, 10)),
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Expanded(
          child: Image.network('https:${day.condition.icon}',
              width: 40, height: 40),
        ),
        Text(
          '${day.maxTempC.round()}° | ${day.minTempC.round()}°',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }
}
