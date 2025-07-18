import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/entities/weather.dart';

class ForecastList extends StatelessWidget {
  final Forecast forecast;
  const ForecastList({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Group weather slots by day (yyyy-MM-dd)
    final Map<String, List<Weather>> groupedByDay = {};
    for (final weather in forecast.daily) {
      final dayKey = DateFormat('yyyy-MM-dd').format(weather.date);
      groupedByDay.putIfAbsent(dayKey, () => []).add(weather);
    }
    final days = groupedByDay.keys.toList()..sort();

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final dayKey = days[index];
            final dayWeathers = groupedByDay[dayKey]!;
            final dayLabel = DateFormat('EEEE, MMM d').format(dayWeathers[0].date);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(dayLabel, style: Theme.of(context).textTheme.titleMedium),
                ),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dayWeathers.length,
                    itemBuilder: (context, idx) {
                      final weather = dayWeathers[idx];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${weather.date.hour.toString().padLeft(2, '0')}:00', style: Theme.of(context).textTheme.labelMedium),
                              Image.network('https://openweathermap.org/img/wn/${weather.icon}@2x.png', width: 40),
                              Text('${weather.temperature}°C'),
                              Text(weather.condition),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
} 