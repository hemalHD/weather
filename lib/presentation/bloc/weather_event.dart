import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWeatherByLocation extends WeatherEvent {
  final double lat;
  final double lon;
  FetchWeatherByLocation({required this.lat, required this.lon});

  @override
  List<Object?> get props => [lat, lon];
}

class FetchWeatherByCity extends WeatherEvent {
  final String city;
  FetchWeatherByCity({required this.city});

  @override
  List<Object?> get props => [city];
} 