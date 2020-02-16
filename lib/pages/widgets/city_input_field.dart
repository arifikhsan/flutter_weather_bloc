import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc/bloc/weather_bloc.dart';

class CityInputField extends StatefulWidget {
  
  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  final TextEditingController textEditingController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    textEditingController.text = 'London';
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: textEditingController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          final weatherBloc = BlocProvider.of<WeatherBloc>(context);
          weatherBloc.add(GetWeather(value));
        },
        decoration: InputDecoration(
          hintText: 'Enter a city',
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
