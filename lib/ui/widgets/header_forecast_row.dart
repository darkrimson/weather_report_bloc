import 'package:flutter/material.dart';

class HeaderForecastRow extends StatelessWidget {
  const HeaderForecastRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.calendar_today_outlined),
        Expanded(
          child: Text("Прогноз на 5 дней"),
        ),
        Text("Подробнее"),
      ],
    );
  }
}
