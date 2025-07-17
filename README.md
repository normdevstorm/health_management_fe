# Health Management App

A Flutter application for appointment booking, medical community interaction and integrating AI-powered features, built with clean architecture principles.

## Features

- Health data tracking and monitoring
- User-friendly interface built with Flutter
- Clean architecture implementation
- Cross-platform support (iOS, Android, Web, Desktop)

## Prerequisites

Before you begin, ensure you have the following installed:

- [Dart SDK](https://dart.dev/get-dart)
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [FVM (Flutter Version Management)](https://fvm.app/docs/getting_started/installation)
- Your preferred IDE (VS Code, Android Studio, or IntelliJ)

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd health_management_fe
```

### 2. Initial Setup

Run the setup script to configure the project:

```bash
./.setup_app.sh
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the Application

```bash
flutter run
```

## Project Structure

This project follows Clean Architecture principles. To generate new feature directories that comply with Clean Architecture:

```bash
bash .gen_clean.sh <feature_name>
```

## Development

### Code Generation

The project uses code generation for various purposes. Run the following command when needed:

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Testing

Run tests using:

```bash
flutter test
```

## Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web
```

## Firebase Configuration

This project includes Firebase integration. Configuration files are managed through:

```bash
./flutterfire-config.sh
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## License

This project is licensed under the MIT License - see the LICENSE file for details.