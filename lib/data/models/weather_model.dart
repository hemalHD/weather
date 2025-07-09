import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required String city,
    required DateTime date,
    required double temperature,
    required String condition,
    required String icon,
    required int humidity,
  }) : super(
          city: city,
          date: date,
          temperature: temperature,
          condition: condition,
          icon: icon,
          humidity: humidity,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
    );
  }
} 