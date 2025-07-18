# Weather App

A Flutter weather app using Clean Architecture, BLoC, and Google Maps.

## Features
- Current weather and 5-day forecast (OpenWeatherMap)
- Google Maps with weather marker at your current location
- Weather details shown below the map in a modern card UI
- Location permission handling with clear error and loading states
- City search and map tap-to-fetch (easy to extend)
- Clean separation of concerns: WeatherBloc for weather, LocationCubit for location
- Error handling for network, GPS, and API issues

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
│   │   ├── weather_bloc.dart
│   │   ├── weather_event.dart
│   │   ├── weather_state.dart
│   │   ├── location_cubit.dart
│   │   └── location_state.dart
│   ├── pages/
│   │   ├── home_page.dart
│   │   └── map_page.dart
│   ├── widgets/
│   │   ├── weather_card.dart
│   │   └── forecast_list.dart
│   └── themes/
├── main.dart
```

## Setup Instructions
1. Clone the repo
2. Run `flutter pub get`
3. Add your OpenWeatherMap and Google Maps API keys in a `.env` file at the project root:
   ```env
   OPENWEATHER_API_KEY=your_openweather_api_key_here
   GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here
   ```
4. The `.env` file is already in `.gitignore` and will not be committed to version control.
5. The app loads environment variables using [flutter_dotenv](https://pub.dev/packages/flutter_dotenv). You can access your API keys in Dart like this:
   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';
   final String apiKey = dotenv.env['OPENWEATHER_API_KEY']!;
   ```
6. Add your Google Maps API key to the native config files as needed:
   - **Android:** In `android/app/src/main/AndroidManifest.xml` inside `<application>`:
     ```xml
     <meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_API_KEY_HERE"/>
     ```
   - **iOS:** In `ios/Runner/AppDelegate.swift` or via Info.plist if needed.
7. Set up location permissions:
   - **Android:** In `android/app/src/main/AndroidManifest.xml`:
     ```xml
     <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
     <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
     ```
   - **iOS:** In `ios/Runner/Info.plist`:
     ```xml
     <key>NSLocationWhenInUseUsageDescription</key>
     <string>This app needs your location to show the weather for your area.</string>
     <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
     <string>This app needs your location to show the weather for your area even when the app is in the background.</string>
     ```
8. Run the app:
   ```
   flutter run
   ```

## How to Run
- `flutter run` (dev)
- `flutter build apk` (release)

## Architecture
- **BLoC:** For weather state management
- **Cubit:** For location state management
- **Clean Architecture:** For maintainable, testable code

## Limitations / Known Issues
- No local cache yet
- No AQI or weather alerts (see bonus ideas)

## Bonus Ideas
- AQI, pull-to-refresh, dark mode, local cache, hourly graph, weather alerts, tap-to-fetch weather on map
