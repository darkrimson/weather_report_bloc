import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report_bloc/blocs/weather_bloc.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final ScrollController scrollController;
  const AppBarWidget(
      {super.key, required this.title, required this.scrollController});
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      title: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        style: scrollController.offset > 200
            ? const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)
            : const TextStyle(
                color: Colors.transparent,
                fontSize: 30,
                fontWeight: FontWeight.bold),
        child: Text(
          title,
        ),
      ),
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
