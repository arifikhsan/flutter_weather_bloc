import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc/bloc/weather_bloc.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_column_with_data.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_error.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_initial_input.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_loading.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Search'),
      ),
      body: Container(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return buildInitialInput();
              } else if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(context, state.weather);
              } else if (state is WeatherError) {
                return buildError();
              }
              return buildInitialInput();
            },
          ),
        ),
      ),
    );
  }
}
