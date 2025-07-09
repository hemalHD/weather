import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return Column(
              children: [
                WeatherCard(weather: state.weather),
                Expanded(child: ForecastList(forecast: state.forecast)),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/map'),
                  child: const Text('Open Map'),
                ),
              ],
            );
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Please allow location or search for a city.'));
        },
      ),
    );
  }
} 