# Weather App

A Flutter weather app using Clean Architecture and BLoC.

## Features
- Current weather and 5-day forecast (OpenWeatherMap)
- Google Maps with weather overlays
- City search with autocomplete
- Error handling for network, GPS, and API issues
- Secure API key management

## Folder Structure
```
lib/
├── core/
│   ├── constants/
│   ├── exceptions/
│   ├── network/
│   ├── usecases/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── bloc/
│   ├── pages/
│   ├── widgets/
│   └── themes/
├── main.dart
```

## Why BLoC?
BLoC provides advanced state management, testability, and separation of concerns, making it ideal for scalable apps.

## Setup Instructions
1. Clone the repo
2. Run `flutter pub get`
3. Add your OpenWeatherMap API key in `lib/data/datasources/weather_remote_data_source.dart`:
   ```dart
   final String _apiKey = 'YOUR_ACTUAL_API_KEY_HERE';
   ```
4. Run the app:
   ```
   flutter run
   ```

## How to Run
- `flutter run` (dev)
- `flutter build apk` (release)

## Limitations / Known Issues
- No local cache yet
- No AQI or weather alerts (see bonus ideas)

## Bonus Ideas
- AQI, pull-to-refresh, dark mode, local cache, hourly graph, weather alerts
