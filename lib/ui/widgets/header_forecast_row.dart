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
            ? const Icon(
                Icons.calendar_today_outlined,
                color: Colors.white,
              )
            : const Icon(
                Icons.av_timer_rounded,
                color: Colors.white,
              ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Text(description,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        description.isNotEmpty
            ? const Icon(
                Icons.chevron_right,
                color: Colors.white,
              )
            : Container(),
      ],
    );
  }
}
