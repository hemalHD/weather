import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Weather> call({required double lat, required double lon}) {
    return repository.getCurrentWeather(lat: lat, lon: lon);
  }
} 