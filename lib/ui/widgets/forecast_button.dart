import 'package:flutter/material.dart';

class ForecastButton extends StatelessWidget {
  const ForecastButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.grey[300]!),
          minimumSize: WidgetStateProperty.all<Size>(
            const Size(300, 50),
          )),
      onPressed: () {},
      child: const Text("Прогноз на 5 дней"),
    );
  }
}
