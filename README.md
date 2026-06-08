# CURE Flutter Assessment

A comprehensive Flutter application demonstrating clean architecture, solid principles, and robust state management for a healthcare booking platform.

## Architecture

This project strictly adheres to **Clean Architecture** with a feature-first folder structure. 
Each feature contains:
- `domain/`: Entities, repository contracts, and use cases. This layer is entirely independent of any frameworks or external libraries.
- `data/`: Models, local/remote data sources, and repository implementations.
- `presentation/`: BLoC/Cubit state management, UI screens, and widgets.

## Key Features

- **Authentication**: Email/password registration and login with domain-level validation.
- **Home Dashboard**: Displays available health services fetched seamlessly.
- **Booking Flow**: Multi-step wizard allowing users to select services, choose available time slots, add medical notes, and confirm bookings.
- **State Machine**: Full lifecycle management of bookings (`Pending` → `Confirmed` → `Completed`/`Cancelled`).
- **Offline Support**: Heavy reliance on local caching using Hive. Network calls gracefully fall back to cached data without user interruption.
- **Responsive UI**: Built with `flutter_screenutil` for pixel-perfect designs across screen sizes.

## Technologies Used

- **State Management**: `flutter_bloc` (Cubit)
- **Dependency Injection**: `get_it` and `injectable`
- **Local Storage**: `hive_ce` and `flutter_secure_storage`
- **Routing**: Standard Flutter `Navigator` with decoupled logic
- **Network**: `dio` (Mocked for assessment)
- **Code Generation**: `build_runner`, `freezed`, `injectable_generator`

## Setup & Run

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Generate Code**
   The project heavily relies on code generation for DI, Freezed models, and Hive adapters.
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Run Application**
   ```bash
   flutter run
   ```

## Mock Data & Local Storage (Hive)

Since this is an assessment project without a live backend, all remote API calls are simulated using **Mock Data** via `MockRemoteDataSource` implementations. 
To mimic a realistic production environment and demonstrate offline-first capabilities, all fetched mock data is immediately registered and persisted locally using **Hive**. 
This architectural choice demonstrates how the application robustly handles caching, offline scenarios, and seamless data synchronization between a remote source and local storage.

## Recent Refactoring Highlights

- **Decoupled Data Layers**: Extracted Hive adapters and data model dependencies from domain entities to ensure strict adherence to Clean Architecture.
- **Cross-Feature Communication**: Implemented `BookingCacheContract` to allow the Dashboard feature to safely read and mutate booking state without violating feature boundaries.
- **Enhanced UX**: Integrated "pull-to-refresh" mechanisms, password visibility toggles, sophisticated email validation, and robust error handling boundaries.
- **Cleaned Navigation Stack**: Fixed stack buildup issues during booking confirmation by leveraging `popUntil`.

## License
Proprietary — All rights reserved.
