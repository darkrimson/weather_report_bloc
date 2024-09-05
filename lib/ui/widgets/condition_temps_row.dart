import 'package:flutter/material.dart';

class ConditionTempsRow extends StatelessWidget {
  final String condition;
  final double maxTemp;
  final double minTemp;
  const ConditionTempsRow({
    super.key,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          condition,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(
          '${maxTemp.round()}° | ${minTemp.round()}°',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}
