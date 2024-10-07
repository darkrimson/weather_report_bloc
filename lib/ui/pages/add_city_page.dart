import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weather_report_bloc/blocs/weather_bloc.dart';

class AddCityPage extends StatelessWidget {
  const AddCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            const Text(
              'Управление городами',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 28,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Flexible(
                    flex: 8,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.blue,
                      controller: textFieldController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.blue,
                        )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: 'Enter City Name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 2,
                    child: IconButton(
                      iconSize: 35,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                      ),
                      onPressed: () {
                        context
                            .read<WeatherBloc>()
                            .add(GetWeatherEvent(textFieldController.text));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  // Пример для отображения списка городов
                  if (state is WeatherLoaded) {
                    final cities = state.weathers; // примерная структура
                    return ListView.builder(
                      itemCount: cities.length, // Количество элементов в списке
                      itemBuilder: (context, index) {
                        final city = cities[index].location.name; // Имя города
                        final currentTempC =
                            cities[index].current.tempC; // Температура
                        final maxTempC = cities[index]
                            .forecast
                            .forecastDay[0]
                            .day
                            .maxTempC; // Максимальная температура
                        final minTempC = cities[index]
                            .forecast
                            .forecastDay[0]
                            .day
                            .minTempC; // Минимальная температура
                        final weatherIcon = cities[index]
                            .current
                            .condition
                            .icon; // Иконка погоды
                        final weatherCondition =
                            cities[index].current.condition.text;
                        return Column(
                          children: [
                            Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.25,
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(10),
                                    onPressed: (context) {
                                      // provider.deleteTask(task);
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.5),
                                color: Colors.blue, // Цвет карточки
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 20),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https:${weatherIcon}',
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(width: 10),
                                      // Информация о городе и погоде
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              city,
                                              style: const TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  weatherCondition,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white70),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  ' ${maxTempC.round()}° | ${minTempC.round()}°',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white70),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      Text(
                                        '${currentTempC.round()}°', // Отображение температуры
                                        style: const TextStyle(
                                          fontSize: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    );
                  } else {
                    // Если данные ещё загружаются или есть ошибка
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
