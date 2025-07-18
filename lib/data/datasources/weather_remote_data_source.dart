import 'package:dio/dio.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource(this.dio);

  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String _apiKey = dotenv.env['OPENWEATHER_API_KEY']!;

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