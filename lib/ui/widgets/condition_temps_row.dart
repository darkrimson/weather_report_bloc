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
    return Row(
      children: [
        Text(
          condition,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          '${maxTemp.round()}° / ${minTemp.round()}°',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
