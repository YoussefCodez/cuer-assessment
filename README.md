Cure Assessment

[![Download APK](https://img.shields.io/badge/Download-APK-green.svg?style=for-the-badge)](https://drive.google.com/file/d/1jbQq5b7IZcHd2kJ-DQlHutZVLZPyOASy/view?usp=sharing)


[VIDEO](https://drive.google.com/file/d/16Wr0piqBjkDQyljtaFyTNaDAPbwwBzTs/view?usp=sharing)

A comprehensive Flutter application demonstrating clean architecture, solid principles, and robust state management for a healthcare booking platform.

## App Screenshots

<p align="center">
  <img width="200" alt="Screenshot_2026-06-09-19-23-41-16_1b6aa7b45a5050b3cbc69b94b21bc2e4" src="https://github.com/user-attachments/assets/7424fbea-9e0c-4b37-a536-826a9f80dd2b" />
  <img width="200"  alt="Screenshot_2026-06-09-19-23-46-55_1b6aa7b45a5050b3cbc69b94b21bc2e4" src="https://github.com/user-attachments/assets/8a773a6d-4b60-4dfd-8fab-46584e83224a" />
  <img width="200"  alt="Screenshot_2026-06-09-19-24-13-12_1b6aa7b45a5050b3cbc69b94b21bc2e4" src="https://github.com/user-attachments/assets/d5e71459-abaf-41b9-a96a-b0a0723fb576" />
  <img width="200"  alt="Screenshot_2026-06-09-19-24-29-47_1b6aa7b45a5050b3cbc69b94b21bc2e4" src="https://github.com/user-attachments/assets/a33df8a0-d67f-43f9-920c-de0e7c6e7fc6" />
  <img width="200"  alt="Screenshot_2026-06-09-19-24-34-33_1b6aa7b45a5050b3cbc69b94b21bc2e4" src="https://github.com/user-attachments/assets/8dc974fe-9834-40b9-84d6-ffe597d19f69" />
  <img width="200"  alt="Screenshot_2026-06-09-19-24-22-12_1b6aa7b45a5050b3cbc69b94b21bc2e4" src="https://github.com/user-attachments/assets/f99af74f-ea99-4741-a832-a1d7a51c79ed" />
  <img width="200"  alt="Screenshot_2026-06-09-19-24-37-32_1b6aa7b45a5050b3cbc69b94b21bc2e4" src="https://github.com/user-attachments/assets/d842f30e-89e9-4ac6-85d2-05d939252dfd" />
  <img width="200" alt="Screenshot_2026-06-09-19-24-53-96_1b6aa7b45a5050b3cbc69b94b21bc2e4" src="https://github.com/user-attachments/assets/0d9b1080-a19d-4af8-b2f9-8d16c5ac3f39" />

</p>

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
- **Code Quality & CI/CD**: Enforces high code quality using a `pre-commit` hook (for formatting and linting before commits) and a GitHub Actions CI/CD workflow for automated quality checks.

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
