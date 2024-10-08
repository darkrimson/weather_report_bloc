import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_report_bloc/blocs/weather_bloc.dart';
import 'package:weather_report_bloc/ui/pages/weather_page.dart';

Future<void> main() async {
  await initializeDateFormatting('en', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc()..add(GetWeatherByLocationEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherPage(),
      ),
    );
  }
}
