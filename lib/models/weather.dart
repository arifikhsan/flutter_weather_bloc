import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperatureCelcius;
  final double temperatureFarenheit;

  Weather({
    @required this.cityName,
    @required this.temperatureCelcius,
    this.temperatureFarenheit,
  });

  @override
  List<Object> get props => [
        cityName,
        temperatureCelcius,
        temperatureFarenheit,
      ];
}
