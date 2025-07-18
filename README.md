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
├── core/           # Core utilities, network, exceptions, usecases
├── data/           # Data sources, models, repositories (implementation)
├── domain/         # Entities, repositories (abstract), usecases
├── presentation/   # UI: bloc, pages, widgets, themes
└── main.dart       # App entry point
```

## Setup Instructions
1. **Clone the repo**
   ```sh
   git clone <repo-url>
   cd weather
   ```
2. **Install dependencies**
   ```sh
   flutter pub get
   ```
3. **API Key Configuration**
   - Create a `.env` file at the project root:
     ```env
     OPENWEATHER_API_KEY=your_openweather_api_key_here
     GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here
     ```
   - (Optional) Copy `.env.example` as a template.
   - The `.env` file is in `.gitignore` and will not be committed.
   - The app loads environment variables using [flutter_dotenv](https://pub.dev/packages/flutter_dotenv):
     ```dart
     import 'package:flutter_dotenv/flutter_dotenv.dart';
     final String apiKey = dotenv.env['OPENWEATHER_API_KEY']!;
     ```
   - **Android Google Maps Key:**
     - In `android/app/src/main/AndroidManifest.xml`:
       ```xml
       <meta-data android:name="com.google.android.geo.API_KEY" android:value="${GOOGLE_MAPS_API_KEY}"/>
       ```
     - In `android/app/build.gradle.kts`, ensure:
       ```kotlin
       manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = project.findProperty("GOOGLE_MAPS_API_KEY") ?: ""
       ```
     - In `android/gradle.properties` (not committed):
       ```
       GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here
       ```
   - **iOS Google Maps Key:**
     - Add to `ios/Runner/AppDelegate.swift` or `Info.plist` as needed.
4. **Set up location permissions:**
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
5. **Run the app:**
   ```sh
   flutter run
   ```

## How to Run
- Development: `flutter run`
- Release build: `flutter build apk` (Android)
- iOS: `flutter build ios`

## How to Run Tests
- Run all tests:
  ```sh
  flutter test
  ```
- Add your tests in the `test/` directory.

## Architectural Decisions
- **State Management:**
  - Uses [BLoC](https://bloclibrary.dev/) for weather state (WeatherBloc) and [Cubit](https://bloclibrary.dev/#/coreconcepts?id=cubit) for location state (LocationCubit).
  - BLoC was chosen for its testability, scalability, and clear separation of business logic from UI.
- **Clean Architecture:**
  - The project is structured into `core`, `data`, `domain`, and `presentation` layers for maintainability and testability.
  - `data` contains concrete implementations, `domain` contains business logic and abstractions, and `presentation` contains UI and state management.
- **API Key Security:**
  - API keys are never committed to source control. They are loaded from `.env` (Flutter) and `gradle.properties` (Android native) at build time.

## Trade-offs Made
- **No Local Caching:**
  - The app fetches fresh data every time. This simplifies the code but may increase network usage and reduce offline usability.
- **No AQI or Weather Alerts:**
  - Focused on core weather and forecast features for MVP. These can be added as enhancements.
- **No Custom Error UI:**
  - Error states are shown as simple text for clarity and maintainability.
- **No Automated CI/CD:**
  - Manual setup for API keys and builds. CI/CD can be added for production.

## Limitations / Known Issues
- No local cache yet
- No AQI or weather alerts (see bonus ideas)

## Bonus Ideas
- AQI, pull-to-refresh, dark mode, local cache, hourly graph, weather alerts, tap-to-fetch weather on map

## Security Note
- **Never commit your `.env` or `android/gradle.properties` with real API keys.**
- Use `.env.example` and `gradle.properties.example` as templates for collaborators.

---

For questions or contributions, please open an issue or pull request.
