import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report_bloc/blocs/weather_bloc.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            context.read<WeatherBloc>().add(GetWeatherByLocationEvent());
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ],
    );
  }
}
