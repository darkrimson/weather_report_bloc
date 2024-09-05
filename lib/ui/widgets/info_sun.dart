import 'package:flutter/material.dart';
import 'package:weather_report_bloc/models/astro.dart';
import 'package:intl/intl.dart';

class InfoSun extends StatelessWidget {
  final Astro astro;
  const InfoSun({
    super.key,
    required this.astro,
  });

  String convertTo24HourFormat(String sunsetTime) {
    // Парсим время заката
    DateTime dateTime = DateFormat("hh:mm").parse(sunsetTime);

    // Добавляем 12 часов, если это вечернее время (например, после полудня)
    DateTime dateTime24Hour = dateTime.add(Duration(hours: 12));

    // Форматируем время в 24-часовой формат
    return DateFormat("HH:mm").format(dateTime24Hour);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  astro.sunrise.substring(0, 5),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Sunrise',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  convertTo24HourFormat(astro.sunset.substring(0, 5)),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Sunset',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
