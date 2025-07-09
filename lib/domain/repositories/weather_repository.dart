import '../entities/weather.dart';
import '../entities/forecast.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather({required double lat, required double lon});
  Future<Forecast> get5DayForecast({required double lat, required double lon});
} 