import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report_bloc/blocs/weather_bloc.dart';

class BackgroundImage extends StatelessWidget {
  final int pageIndex;

  const BackgroundImage({required this.pageIndex, super.key});

  String _getBackgroundImage(WeatherLoaded state, int pageIndex) {
    final keywordToImage = {
      'night': 'assets/night.jpg',
      'sunny': 'assets/sunny.jpg',
      'rain': 'assets/rain.jpg',
      'cloud': 'assets/cloud.jpg',
      'snow': 'assets/snow.jpg',
      'mint': 'assets/mint.jpg',
      'clear': 'assets/cloud.jpg',
    };

    final condition =
        state.weathers[pageIndex].current.condition.text.toLowerCase();

    // Поиск первого совпадения ключевого слова в условии
    final matchedKeyword = keywordToImage.keys.firstWhere(
      (keyword) => condition.contains(keyword),
      orElse: () => '',
    );

    return keywordToImage[matchedKeyword] ?? 'assets/default.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        String backgroundImage = '';

        if (state is WeatherLoaded) {
          backgroundImage = _getBackgroundImage(state, pageIndex);
        }

        return backgroundImage.isNotEmpty
            ? Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : Container();
      },
    );
  }
}
