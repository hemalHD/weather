import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> fetchLocation() async {
    emit(LocationLoading());
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError('Location permission denied.'));
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        emit(LocationError('Location permission permanently denied.'));
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      emit(LocationLoaded(LatLng(position.latitude, position.longitude)));
    } catch (e) {
      emit(LocationError('Failed to get location: ${e.toString()}'));
    }
  }
} 