import 'package:flutter/material.dart';

class ForecastButton extends StatelessWidget {
  const ForecastButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
              Colors.grey[300]!.withOpacity(0.3)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          minimumSize: WidgetStateProperty.all<Size>(
            const Size(300, 50),
          )),
      onPressed: () {},
      child: const Text(
        "Прогноз на 5 дней",
        style: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
