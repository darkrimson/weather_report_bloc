import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_report_bloc/models/weather.dart';

import 'widgets.dart';

class ForecastButton extends StatelessWidget {
  final Weather weather;
  const ForecastButton({
    super.key,
    required this.weather,
  });

  String getWeekday(String date) {
    // Парсим строку с датой в формат DateTime
    DateTime dateTime = DateTime.parse(date);

    // Форматируем дату в день недели
    String weekday = DateFormat('EEEE', 'en').format(dateTime);

    return weekday;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> date = [
      weather.forecast.forecastDay[1].date,
      weather.forecast.forecastDay[2].date,
    ];
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
      onPressed: () {
        _modalBottomSheet(context, date);
      },
      child: const Text(
        "Прогноз на 2 дня",
        style: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<dynamic> _modalBottomSheet(BuildContext context, List<String> date) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(text: getWeekday(date[0].toString().substring(0, 10))),
                    Tab(text: getWeekday(date[1].toString().substring(0, 10))),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildWeatherContent(
                          context, weather.forecast.forecastDay[1]),
                      _buildWeatherContent(
                          context, weather.forecast.forecastDay[2]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildWeatherContent(BuildContext context, forecastDay) {
    return ListView(
      children: [
        _headerInfoTemp(forecastDay),
        Text(
          forecastDay.day.condition.text,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 20),
        _hourList(forecastDay),
        const SizedBox(height: 20),
        _containersGridList(forecastDay)
      ],
    );
  }

  GridView _containersGridList(forecastDay) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Количество колонок
        childAspectRatio: 3.5 / 2, // Соотношение сторон контейнеров
        crossAxisSpacing: 10, // Расстояние между колонками
        mainAxisSpacing: 10, // Расстояние между рядами
      ),
      itemCount: 4, // Количество элементов в GridView
      itemBuilder: (context, index) {
        final List<String> titles = [
          'Humidity',
          'UV',
          'Chanse of Rain',
          'Wind',
        ];
        final List stateDay = [
          forecastDay.day.humidity,
          forecastDay.day.uv,
          forecastDay.day.chanceOfRain,
          forecastDay.day.maxWind,
        ];
        final List<String> icons = [
          'assets/icons/humidity.png',
          'assets/icons/uv.png',
          'assets/icons/rain.png',
          'assets/icons/wind.png',
        ];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 44, 108, 160)
                .withOpacity(0.2), // Цвет контейнера
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image.asset(
                icons[index],
                width: 39,
                height: 40,
              ),
              const SizedBox(width: 10), // Отступ между иконкой и текстом
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[index], // Первый текст
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${stateDay[index]}', // Второй текст
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Container _hourList(forecastDay) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 44, 108, 160).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.av_timer_rounded,
                  color: Colors.black,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Forecasy for 24 hours',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: forecastDay.hour.length,
                itemBuilder: (BuildContext context, int index) {
                  var hour = forecastDay.hour[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HourCard(
                      hour: hour,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _headerInfoTemp(forecastDay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${forecastDay.day.maxTempC.round()}° | ${forecastDay.day.minTempC.round()}°',
          style: const TextStyle(
              fontSize: 60, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Image.network(
          'https:${forecastDay.day.condition.icon}',
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
