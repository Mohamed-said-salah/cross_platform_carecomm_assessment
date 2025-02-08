# CareComm Task - Product Listing App 📱
CareComm Task is a cross-platform product listing application built using Flutter. The app allows users to browse products, view details, and manage their favorite items. It is designed with a responsive layout to support mobile, tablet, and desktop screens seamlessly.

# Languages and frameworks 📑
 * Flutter: version 3.27.2
 * Dart: version 3.6.1
   
## Packages & Plugins 🔎
##### State Management & Dependency Injection
 * flutter_bloc - State management.
 * hydrated_bloc - Persistent flutter bloc state management after app closed.
 * get_it - Service locator for dependency injection.
##### Networking & HTTP
 * http - A powerful HTTP client for making network requests.
 * http_mock_adapter - A Dio adapter for mocking API responses in tests.
##### Routing & Navigation
 * auto_route - Declarative and type-safe routing for Flutter.
 * auto_route_generator - Code generation for auto_route.
##### Local Storage & Caching
 * shared_preferences - Persistent key-value storage.
 * path_provider - Provides access to commonly used storage locations.
 * fast_cached_network_image - Efficient caching for network images.
##### UI & Responsiveness
 * flutter_screenutil - Adaptive screen sizing for different devices.
 * skeletonizer - Adds skeleton loading effects to UI components.
##### Testing & Code Generation
 * mockito - Mocking framework for unit testing.
 * bloc_test - Unit testing utilities for BLoC.
 * build_runner - Code generation tool for Flutter.


## Features 🥇
 * Product Listing: Displays a list of products with a smooth UI.
 * Favorites Management: Users can mark products as favorites for quick access.
 * Adaptive UI: The app adjusts its layout based on the screen size (Responsive design for mobile, tablet, and desktop).
 * State Management: Powered by Flutter BLoC for efficient data handling.
 * Dark Mode Support: Toggle between light and dark themes dynamically.
 * Navigation: Implemented using AutoRoute for seamless routing across screens.
 * Supports both Web and Mobile platforms

## IDEs 💻
 * VS code
 * Android Studio

## Get the App 📱
 * Android APK: [**Download from Google Drive**](https://drive.google.com/file/d/1-BTUUwfTQ6z0pbqbHpaM010r0GBQKT2g/view?usp=sharing)
 * Latest Build (Mobile APK) Download or Generate Latest from GitHub Actions Artifacts: [**Workflow Link**](https://github.com/Mohamed-said-salah/cross_platform_carecomm_assessment/actions/runs/13214215125)
 * Web Version: [**Open on GitHub Pages**](https://mohamed-said-salah.github.io/cross_platform_carecomm_assessment/)

## Setup 💽
To get a local copy up and running, follow these instructions.

Prerequisites

 * Flutter SDK: Ensure Flutter is installed on your system. Follow Flutter installation guide
 * Android Studio or Visual Studio Code for development and testing.
 * clone the repository
 * Ensure your device's Internet connection is enabled.
 * and run the app on any plugged physical device, emulator or web browser.

## Installation
   ``` bash 
      # Clone the repository
      git clone https://github.com/Mohamed-said-salah/cross_platform_carecomm_assessment.git
      cd cross_platform_carecomm_assessment
   ```
   ``` bash
      # Install dependencies
      flutter pub get
   ```
   ``` bash
      # Run the application on an physical Android device, emulator, or web browswer
      flutter run
   ```

   ``` bash
      # Build the APK
      flutter build apk --release
   ```

## Project Structure
   ``` bash
      .
      └── lib/
          ├── services/
          │   └── permissions.services.dart
          ├── features/
          │   ├── services_and_permissions/
          │   │   ├── data/
          │   │   │   ├── repos
          │   │   │   └── models
          │   │   ├── views/
          │   │   │   ├── screens/
          │   │   │   │   ├── enable_bluetooth_screen.dart
          │   │   │   │   ├── enable_location_screen.dart
          │   │   │   │   ├── request_bluetooth_permissions_screen.dart
          │   │   │   │   └── request_location_permissions_screen.dart
          │   │   │   └── widgets/
          │   │   │       └── buttons/...
          │   │   └── view_models/
          │   │       ├── bluetooth/
          │   │       │   ├── bluetooth_status_cubit.dart
          │   │       │   └── bluetooth_status_state.dart
          │   │       └── location/
          │   │           ├── location_status_cubit.dart
          │   │           └── location_status_state.dart
          │   ├── scan_near_by_devices/...
          │   └── data_exchange/...
          ├── constants/...
          └── main.dart
   ```

## ScreenShots 🖼️
<div align='center'>
  <img height="460px" src="https://github.com/user-attachments/assets/9cfb6b31-2c9c-408b-9ebc-89f89c849abd">
  <img height="460px" src="https://github.com/user-attachments/assets/3ce7c6ad-b33b-464c-84a7-db8a50b56f72">
  <img height="460px" src="https://github.com/user-attachments/assets/d35fda79-fedb-410a-a9d5-57220b257f9c">
  <img height="460px" src="https://github.com/user-attachments/assets/7d76812b-5e96-454f-bb03-fd96b18ed184">
<hr/>
</div>
