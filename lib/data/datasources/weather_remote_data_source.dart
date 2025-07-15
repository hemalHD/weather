import 'package:dio/dio.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource(this.dio);

  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String _apiKey = '2de32be03790847581ba8560c7dea935';

  Future<WeatherModel> getCurrentWeather({required double lat, required double lon}) async {
    final response = await dio.get(
      '$_baseUrl/weather',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': _apiKey,
        'units': 'metric',
      },
    );
    return WeatherModel.fromJson(response.data);
  }

  Future<ForecastModel> get5DayForecast({required double lat, required double lon}) async {
    final response = await dio.get(
      '$_baseUrl/forecast',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': _apiKey,
        'units': 'metric',
      },
    );
    return ForecastModel.fromJson(response.data);
  }
} 