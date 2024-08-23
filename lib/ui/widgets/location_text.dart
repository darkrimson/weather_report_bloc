import 'package:flutter/material.dart';

class LocationText extends StatelessWidget {
  final String text;
  const LocationText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.white,
      ),
    );
  }
}
