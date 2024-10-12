import 'package:flutter/material.dart';
import 'package:weather_report_bloc/models/hour.dart';

class HourCard extends StatelessWidget {
  final Color color;
  const HourCard({
    super.key,
    required this.hour,
    required this.color,
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
            hour.time,
            style: TextStyle(fontSize: 18, color: color),
          ),
          Image.network(
            'https:${hour.condition.icon}',
          ),
          Text(
            '${hour.tempC.round()}°',
            style: TextStyle(fontSize: 18, color: color),
          ),
        ],
      ),
    );
  }
}
