import 'package:flutter/material.dart';

import 'widgets.dart';

class DetailsColumn extends StatelessWidget {
  const DetailsColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DetailsColumnRow(text: 'Humidity', value: '62%'),
            Divider(),
            DetailsColumnRow(text: 'Real feel', value: '25 o'),
            Divider(),
            DetailsColumnRow(text: 'UV', value: '6'),
            Divider(),
            DetailsColumnRow(text: 'Chance of rain', value: '61%'),
            Divider()
          ],
        ),
      ),
    );
  }
}
