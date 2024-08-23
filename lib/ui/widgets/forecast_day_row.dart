import 'package:flutter/material.dart';

class ForecastDayRow extends StatelessWidget {
  final String dayLabel;
  final double maxTemp;
  final double minTemp;
  final String iconUrl;

  const ForecastDayRow({
    super.key,
    required this.dayLabel,
    required this.maxTemp,
    required this.minTemp,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(dayLabel),
        ),
        Expanded(
          child: Image.network('https:$iconUrl', width: 40, height: 40),
        ),
        Text(
          '${maxTemp.round()}° / ${minTemp.round()}°',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
