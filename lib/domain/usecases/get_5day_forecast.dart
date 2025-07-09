import '../entities/forecast.dart';
import '../repositories/weather_repository.dart';

class Get5DayForecast {
  final WeatherRepository repository;

  Get5DayForecast(this.repository);

  Future<Forecast> call({required double lat, required double lon}) {
    return repository.get5DayForecast(lat: lat, lon: lon);
  }
} 