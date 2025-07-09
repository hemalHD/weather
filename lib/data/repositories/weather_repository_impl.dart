import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Weather> getCurrentWeather({required double lat, required double lon}) async {
    try {
      return await remoteDataSource.getCurrentWeather(lat: lat, lon: lon);
    } catch (e) {
      throw Exception('Failed to fetch current weather: $e');
    }
  }

  @override
  Future<Forecast> get5DayForecast({required double lat, required double lon}) async {
    try {
      return await remoteDataSource.get5DayForecast(lat: lat, lon: lon);
    } catch (e) {
      throw Exception('Failed to fetch forecast: $e');
    }
  }
} 