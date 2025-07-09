import 'package:equatable/equatable.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final Forecast forecast;

  WeatherLoaded({required this.weather, required this.forecast});

  @override
  List<Object?> get props => [weather, forecast];
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);

  @override
  List<Object?> get props => [message];
} 