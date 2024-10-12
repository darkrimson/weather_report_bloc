import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report_bloc/models/weather.dart';
import 'package:weather_report_bloc/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final weatherRepository = WeatherRepository();
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeatherEvent>(_getWeather);
    on<GetWeatherByLocationEvent>(_getWeatherByLocation);
    on<DeleteWeatherEvent>(_deleteWeather);
  }

  List<Weather> citiesWeather = [];

  Future<void> _getWeather(
      GetWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.fetchWeather(event.cityName);
      if (citiesWeather.contains(weather)) {
        emit(WeatherLoaded(citiesWeather));
        return;
      }
      citiesWeather.add(weather);
      emit(WeatherLoaded(citiesWeather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> _getWeatherByLocation(
      GetWeatherByLocationEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.fetchWeatherByLocation();
      if (citiesWeather.contains(weather)) {
        emit(WeatherLoaded(citiesWeather));
        return;
      }
      citiesWeather.add(weather);
      emit(WeatherLoaded(citiesWeather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> _deleteWeather(
      DeleteWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      if (citiesWeather.length <= 1) {
      } else {
        citiesWeather.remove(event.weather);
      }
      emit(WeatherLoaded(citiesWeather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
