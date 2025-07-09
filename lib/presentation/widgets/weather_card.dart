import 'package:flutter/material.dart';
import '../../domain/entities/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(weather.city, style: Theme.of(context).textTheme.headlineMedium),
            Text('${weather.temperature}°C', style: Theme.of(context).textTheme.headlineMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('https://openweathermap.org/img/wn/${weather.icon}@2x.png', width: 50),
                const SizedBox(width: 8),
                Text(weather.condition, style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
            Text('Humidity: ${weather.humidity}%'),
          ],
        ),
      ),
    );
  }
} 