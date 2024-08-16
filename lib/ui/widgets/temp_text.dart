import 'package:flutter/material.dart';

class TempText extends StatelessWidget {
  final String text;
  const TempText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 150, height: 1.1),
    );
  }
}
