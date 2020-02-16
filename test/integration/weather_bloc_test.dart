import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_bloc/bloc/weather_bloc.dart';
import 'package:flutter_weather_bloc/data/weather_repository.dart';
import 'package:flutter_weather_bloc/models/weather.dart';
import 'package:mockito/mockito.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
  });

  group('GetWeather', () {
    final weather = Weather(
      cityName: 'London',
      temperatureCelcius: 7,
    );

    test('OLD WAY emits [WeatherLoading, WeatherLoaded] when successful', () {
      when(mockWeatherRepository.fetchWeather(any))
          .thenAnswer((_) async => weather);

      final bloc = WeatherBloc(mockWeatherRepository);
      bloc.add(GetWeather('London'));
      expectLater(
        bloc,
        emitsInOrder(
          [
            WeatherInitial(),
            WeatherLoading(),
            WeatherLoaded(weather),
          ],
        ),
      );
    });

    test('NEW WAY emits [WeatherLoading, WeatherLoaded] when successful', () {
      when(mockWeatherRepository.fetchWeather(any))
          .thenAnswer((_) async => weather);

      final bloc = WeatherBloc(mockWeatherRepository);
      bloc.add(GetWeather('London'));
      emitsExactly(
        bloc,
        [
          WeatherInitial(),
          WeatherLoading(),
          WeatherLoaded(weather),
        ],
      );
    });

    blocTest(
      'emits sucess',
      build: () {
        when(mockWeatherRepository.fetchWeather(any))
            .thenAnswer((_) async => weather);
      },
      act: (bloc) => bloc.add(GetWeather('London')),
      expect: [
        WeatherInitial(),
        WeatherLoading(),
        WeatherLoaded(weather),
      ],
    );

    blocTest(
      'emits [WeatherLoading, WeatherError] when unsuccessful',
      build: () {
        when(mockWeatherRepository.fetchWeather(any)).thenThrow(NetworkError());
        return WeatherBloc(mockWeatherRepository);
      },
      act: (bloc) => bloc.add(GetWeather('London')),
      expect: [
        WeatherInitial(),
        WeatherLoading(),
        WeatherError("Couldn't fetch weather. Is the device online?"),
      ],
    );
  });
}
