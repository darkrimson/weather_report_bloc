import 'package:flutter/material.dart';

class ForecastDayRow extends StatelessWidget {
  final String dayLabel;
  final double maxTemp;
  final double minTemp;

  const ForecastDayRow({
    Key? key,
    required this.dayLabel,
    required this.maxTemp,
    required this.minTemp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(dayLabel),
        ),
        const Expanded(
          child: Icon(Icons.calendar_today_outlined),
        ),
        Text(
          '${maxTemp.round()}° / ${minTemp.round()}°',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
