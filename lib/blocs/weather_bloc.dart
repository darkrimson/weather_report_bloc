import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report_bloc/models/weather.dart';
import 'package:weather_report_bloc/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<GetWeatherEvent>(_getWeather);
    on<GetWeatherByLocationEvent>(_getWeatherByLocation);
  }

  Future<void> _getWeather(
      GetWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.fetchWeather(event.cityName);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> _getWeatherByLocation(
      GetWeatherByLocationEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.fetchWeatherByLocation();
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
