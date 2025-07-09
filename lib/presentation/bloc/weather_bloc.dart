import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/get_5day_forecast.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final Get5DayForecast get5DayForecast;

  WeatherBloc({required this.getCurrentWeather, required this.get5DayForecast}) : super(WeatherInitial()) {
    on<FetchWeatherByLocation>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await getCurrentWeather(lat: event.lat, lon: event.lon);
        final forecast = await get5DayForecast(lat: event.lat, lon: event.lon);
        emit(WeatherLoaded(weather: weather, forecast: forecast));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
    // City search can be implemented with a geocoding API or OpenWeatherMap's city endpoint
  }
} 