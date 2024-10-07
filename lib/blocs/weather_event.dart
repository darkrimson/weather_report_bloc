part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherEvent extends WeatherEvent {
  final String cityName;

  const GetWeatherEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class GetWeatherByLocationEvent extends WeatherEvent {
  @override
  List<Object> get props => [];
}

class DeleteWeatherEvent extends WeatherEvent {
  final Weather weather;
  const DeleteWeatherEvent(this.weather);

  @override
  List<Object> get props => [weather];
}
