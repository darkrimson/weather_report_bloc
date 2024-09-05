import 'package:flutter/material.dart';
import 'package:weather_report_bloc/models/hour.dart';

class HourCard extends StatelessWidget {
  const HourCard({
    super.key,
    required this.hour,
  });

  final Hour hour;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            hour.time as String,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Image.network(
            'https:${hour.condition.icon}',
          ),
          Text(
            '${hour.tempC.round()}°',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
