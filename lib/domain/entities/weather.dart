import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String city;
  final DateTime date;
  final double temperature;
  final String condition;
  final String icon;
  final int humidity;

  const Weather({
    required this.city,
    required this.date,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
  });

  @override
  List<Object?> get props => [city, date, temperature, condition, icon, humidity];
} 