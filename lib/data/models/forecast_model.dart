import '../../domain/entities/forecast.dart';
import '../../domain/entities/weather.dart';
import 'weather_model.dart';

class ForecastModel extends Forecast {
  ForecastModel({
    required String city,
    required List<Weather> daily,
  }) : super(city: city, daily: daily);

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final city = json['city']['name'];
    final List<Weather> daily = (json['list'] as List)
        .map((item) => WeatherModel.fromJson({
              ...item,
              'name': city,
            }))
        .toList();
    return ForecastModel(city: city, daily: daily);
  }
} 