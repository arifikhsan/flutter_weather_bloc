import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc/bloc/weather_bloc.dart';
import 'package:flutter_weather_bloc/models/weather.dart';
import 'package:flutter_weather_bloc/pages/weather_detail_page.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_column_with_data.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_initial_input.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_loading.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_loading_error.dart';

class WeatherSearchPage extends StatelessWidget {
  const WeatherSearchPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Search'),
      ),
      body: Container(
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
    );
  }
}
