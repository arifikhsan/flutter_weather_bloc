import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_bloc/models/weather.dart';
import 'package:flutter_weather_bloc/data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is GetWeather) {
      try {
        final weather = await repository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError('Cloudn\'t fetch weater. is the devide online?');
      }
    } else if (event is GetDetailWeather) {
      try {
        final weather = await repository.fetchWeatherDetail(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError('Cloudn\'t fetch weater. is the devide online?');
      }
    }
  }
}
