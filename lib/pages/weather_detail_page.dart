import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc/bloc/weather_bloc.dart';
import 'package:flutter_weather_bloc/models/weather.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_column_with_data.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_detail_weather.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_error.dart';
import 'package:flutter_weather_bloc/pages/widgets/build_loading.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather masterWeather;

  const WeatherDetailPage({
    Key key,
    @required this.masterWeather,
  }) : super(key: key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)
      ..add(GetDetailWeather(widget.masterWeather.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Detail'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildDetailWeather(context, state.weather);
            } else if (state is WeatherError) {
              return buildError();
            }
            return buildLoading();
          },
        ),
      ),
    );
  }
}
