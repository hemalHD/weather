import 'package:equatable/equatable.dart';
import 'weather.dart';

class Forecast extends Equatable {
  final String city;
  final List<Weather> daily;

  const Forecast({
    required this.city,
    required this.daily,
  });

  @override
  List<Object?> get props => [city, daily];
} 