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
            color: Colors.black,
            width: 1,
          )),
      child: Column(
        children: [
          Text(
            '${hour.tempC.round()}°',
            style: TextStyle(fontSize: 18),
          ),
          Image.network(
            'https:${hour.condition.icon}',
          ),
          Text(hour.time, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
