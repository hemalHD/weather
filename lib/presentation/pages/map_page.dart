import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';
import '../bloc/weather_event.dart';
import '../bloc/location_cubit.dart';
import '../widgets/weather_card.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Weather Map')),
        body: BlocProvider(
          create: (_) => LocationCubit()..fetchLocation(),
          child: BlocBuilder<LocationCubit, LocationState>(
            builder: (context, locationState) {
              if (locationState is LocationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (locationState is LocationError) {
                return Center(child: Text(locationState.message));
              } else if (locationState is LocationLoaded) {
                // When location is loaded, trigger weather fetch
                context.read<WeatherBloc>().add(FetchWeatherByLocation(
                  lat: locationState.position.latitude,
                  lon: locationState.position.longitude,
                ));
                return BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, weatherState) {
                    Set<Marker> markers = {
                      Marker(
                        markerId: const MarkerId('current'),
                        position: locationState.position,
                        infoWindow: weatherState is WeatherLoaded
                            ? InfoWindow(
                                title: '${weatherState.weather.temperature}°C',
                                snippet: 'Humidity: ${weatherState.weather.humidity}%\n${weatherState.weather.condition}',
                              )
                            : const InfoWindow(title: 'Current Location'),
                      ),
                    };
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(target: locationState.position, zoom: 10),
                                markers: markers,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                              ),
                            ),
                          ),
                        ),
                        _buildWeatherDetails(context, weatherState),
                      ],
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetails(BuildContext context, WeatherState state) {
    if (state is WeatherLoaded) {
      final weather = state.weather;
      return Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.thermostat, color: Colors.orange, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    '${weather.temperature}°C',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    weather.condition,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.water_drop, color: Colors.blue, size: 24),
                  const SizedBox(width: 8),
                  Text('Humidity: ${weather.humidity}%'),
                ],
              ),
              // Add more weather details here if available
            ],
          ),
        ),
      );
    } else if (state is WeatherLoading) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (state is WeatherError) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(child: Text(state.message, style: TextStyle(color: Colors.red))),
      );
    }
    return const SizedBox.shrink();
  }
} 