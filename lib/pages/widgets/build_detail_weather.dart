import 'package:flutter/material.dart';
import 'package:flutter_weather_bloc/models/weather.dart';

Column buildDetailWeather(BuildContext context, Weather weather) {
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
      Text(
        '${weather.temperatureFarenheit.toStringAsFixed(1)} °C',
        style: TextStyle(fontSize: 80),
      ),
      RaisedButton(
        child: Text('Back'),
        color: Colors.lightBlue.shade100,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
