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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Map')),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoaded) {
            final LatLng position = LatLng(state.weather.city == '' ? 0 : state.weather.city as double, 0); // Replace with actual lat/lon
            return GoogleMap(
              onMapCreated: (controller) => _controller = controller,
              initialCameraPosition: CameraPosition(target: position, zoom: 10),
              markers: {
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
                      builder: (_) => ListTile(
                        title: Text('${state.weather.temperature}°C'),
                        subtitle: Text('Humidity: ${state.weather.humidity}%'),
                      ),
                    );
                  },
                ),
              },
              tileOverlays: {
                TileOverlay(
                  tileOverlayId: const TileOverlayId('weather'),
                  tileProvider: UrlTileProvider(
                    urlTemplate: "https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=YOUR_API_KEY",
                  ),
                ),
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Center map on user location
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
} 