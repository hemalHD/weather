// Entry point for Weather app. Will be updated to use Clean Architecture + BLoC.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/dio_client.dart';
import 'data/datasources/weather_remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/usecases/get_current_weather.dart';
import 'domain/usecases/get_5day_forecast.dart';
import 'presentation/bloc/weather_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = DioClient().dio;
  final remoteDataSource = WeatherRemoteDataSource(dio);
  final repository = WeatherRepositoryImpl(remoteDataSource);
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final WeatherRepositoryImpl repository;
  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WeatherBloc(
            getCurrentWeather: GetCurrentWeather(repository),
            get5DayForecast: Get5DayForecast(repository),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/map': (context) => const MapPage(),
        },
      ),
    );
  }
}
