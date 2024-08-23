import 'package:flutter/material.dart';

class HeaderForecastRow extends StatelessWidget {
  final String text;
  final String description;
  const HeaderForecastRow(
    this.description, {
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        description.isNotEmpty
            ? const Icon(Icons.calendar_today_outlined)
            : const Icon(Icons.av_timer_rounded),
        const SizedBox(width: 5),
        Expanded(
          child: Text(text),
        ),
        Text(description ?? ''),
        description.isNotEmpty ? const Icon(Icons.chevron_right) : Container(),
      ],
    );
  }
}
