import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc/bloc/weather_bloc.dart';
import 'package:flutter_weather_bloc/models/weather.dart';
import 'package:flutter_weather_bloc/pages/weather_detail_page.dart';

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
              return buildInitialInput();
            }
            return buildInitialInput();
          },
        ),
      ),
    );
  }
}

Widget buildInitialInput() {
  return Center(
    child: CityInputField(),
  );
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

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

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          // context.bloc().add(GetWeather(value));
          return submitCityName(context, value);
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

  void submitCityName(BuildContext context, String cityName) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(cityName));
  }
}
