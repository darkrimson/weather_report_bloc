import 'package:flutter/material.dart';
import 'package:weather_report_bloc/models/day.dart';

class ConditionTempsRow extends StatelessWidget {
  final Day day;
  const ConditionTempsRow({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day.condition.text,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(
          '${day.maxTempC.round()}° | ${day.minTempC.round()}°',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}
