import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc/bloc/weather_bloc.dart';
import 'package:flutter_weather_bloc/models/weather.dart';
import 'package:flutter_weather_bloc/pages/weather_detail_page.dart';
import 'package:flutter_weather_bloc/pages/widgets/city_input_field.dart';

Column buildColumnWithData(BuildContext context, Weather weather) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(
        weather.cityName,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        '${weather.temperatureCelcius.toStringAsFixed(1)} °C',
        style: TextStyle(fontSize: 80),
      ),
      RaisedButton(
        child: Text('See details'),
        color: Colors.lightBlue.shade100,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return BlocProvider.value(
                  value: BlocProvider.of<WeatherBloc>(context),
                  child: WeatherDetailPage(
                    masterWeather: weather,
                  ),
                );
              },
            ),
          );
        },
      ),
      CityInputField(),
    ],
  );
}
