part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LatLng position;
  const LocationLoaded(this.position);

  @override
  List<Object?> get props => [position];
}

class LocationError extends LocationState {
  final String message;
  const LocationError(this.message);

  @override
  List<Object?> get props => [message];
} 