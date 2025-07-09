import 'package:flutter/material.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/entities/weather.dart';

class ForecastList extends StatelessWidget {
  final Forecast forecast;
  const ForecastList({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.daily.length,
        itemBuilder: (context, index) {
          final Weather weather = forecast.daily[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${weather.date.month}/${weather.date.day}', style: Theme.of(context).textTheme.labelMedium),
                  Image.network('https://openweathermap.org/img/wn/${weather.icon}@2x.png', width: 40),
                  Text('${weather.temperature}°C'),
                  Text(weather.condition),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 