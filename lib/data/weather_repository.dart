import 'dart:math';

import 'package:flutter_weather_bloc/models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
  Future<Weather> fetchWeatherDetail(String cityName);
}

class NetworkError extends Error {}

class FakeWeatherRepository implements WeatherRepository {
  double cachedTempCelcius;

  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      final random = Random();
      if (random.nextBool()) {
        throw NetworkError();
      }

      cachedTempCelcius = 20 + random.nextInt(15) + random.nextDouble();
      return Weather(
        cityName: cityName,
        temperatureCelcius: cachedTempCelcius,
      );
    });
  }

  @override
  Future<Weather> fetchWeatherDetail(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      return Weather(
        cityName: cityName,
        temperatureCelcius: cachedTempCelcius,
        temperatureFarenheit: cachedTempCelcius,
      );
    });
  }
}
