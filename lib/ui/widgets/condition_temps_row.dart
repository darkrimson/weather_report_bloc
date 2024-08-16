import 'package:flutter/material.dart';

class ConditionTempsRow extends StatelessWidget {
  final String conditionText;
  final String maxTempText;
  final String minTempText;
  const ConditionTempsRow({
    super.key,
    required this.conditionText,
    required this.maxTempText,
    required this.minTempText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          conditionText,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          '$maxTempText° / $minTempText°',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
