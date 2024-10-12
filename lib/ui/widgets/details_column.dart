import 'package:flutter/material.dart';
import 'package:weather_report_bloc/models/current.dart';
import 'package:weather_report_bloc/models/day.dart';

import 'widgets.dart';

class DetailsColumn extends StatelessWidget {
  final Current current;
  final Day day;
  const DetailsColumn({
    super.key,
    required this.current,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DetailsColumnRow(text: 'Humidity', value: '${current.humidity} %'),
            const Divider(),
            DetailsColumnRow(
                text: 'Real feel', value: '${current.feelsLikeC} °'),
            const Divider(),
            DetailsColumnRow(text: 'UV', value: current.uv.toString()),
            const Divider(),
            DetailsColumnRow(
                text: 'Chance of rain', value: '${day.chanceOfRain} %'),
            const Divider()
          ],
        ),
      ),
    );
  }
}
