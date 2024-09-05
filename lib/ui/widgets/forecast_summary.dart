import 'package:flutter/material.dart';

import 'widgets.dart';

class ForecastSummary extends StatelessWidget {
  const ForecastSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: const Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoWind(),
              SizedBox(height: 10),
              InfoSun(),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          DetailsColumn(),
        ],
      ),
    );
  }
}
