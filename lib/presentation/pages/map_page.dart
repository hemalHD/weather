import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Map')),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoaded) {
            // Use a default position (London) for now - you'll replace this with actual coordinates
            final LatLng position = const LatLng(51.5074, -0.1278);
            
            // Update markers
            _markers = {
              Marker(
                markerId: const MarkerId('current'),
                position: position,
                infoWindow: InfoWindow(
                  title: '${state.weather.temperature}°C',
                  snippet: 'Humidity: ${state.weather.humidity}%',
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${state.weather.temperature}°C',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 8),
                          Text('Humidity: ${state.weather.humidity}%'),
                          Text('Condition: ${state.weather.condition}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            };

            return GoogleMap(
              onMapCreated: (controller) => _controller = controller,
              initialCameraPosition: CameraPosition(target: position, zoom: 10),
              markers: _markers,
              // Note: Custom tile overlays require a custom TileProvider implementation
              // For now, we'll use the default map tiles
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Center map on user location
          if (_controller != null && _markers.isNotEmpty) {
            final marker = _markers.first;
            _controller!.animateCamera(
              CameraUpdate.newLatLng(marker.position),
            );
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
} 