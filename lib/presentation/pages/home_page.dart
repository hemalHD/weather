import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';
import '../bloc/weather_event.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _locationLoading = true;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    _fetchLocationAndWeather();
  }

  Future<void> _fetchLocationAndWeather() async {
    setState(() {
      _locationLoading = true;
      _locationError = null;
    });
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationError = 'Location permission denied.';
            _locationLoading = false;
          });
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationError = 'Location permission permanently denied.';
          _locationLoading = false;
        });
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      context.read<WeatherBloc>().add(
        FetchWeatherByLocation(lat: position.latitude, lon: position.longitude),
      );
      setState(() {
        _locationLoading = false;
      });
    } catch (e) {
      setState(() {
        _locationError = 'Failed to get location: \\${e.toString()}';
        _locationLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body:
          _locationLoading
              ? const Center(child: CircularProgressIndicator())
              : _locationError != null
              ? Center(child: Text(_locationError!))
              : BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WeatherLoaded) {
                    return Column(
                      children: [
                        WeatherCard(weather: state.weather),
                        ForecastList(forecast: state.forecast),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/map'),
                          child: const Text('Open Map'),
                        ),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(
                    child: Text('Please allow location or search for a city.'),
                  );
                },
              ),
    );
  }
}
