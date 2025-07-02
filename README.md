# Scada Remedy (MPPKVVCL Mobile App)

A mobile application for complaint management for MPPKVVCL, built with Flutter. The app allows users to register, track, and manage complaints related to Control Center, Substation, Feeders, and Line Equipment. Powered by NEXTIN LABS.

## Features

- **User Authentication**: Secure login for users.
- **Complaint Categories**: Register complaints for:
  - Control Center
  - Substation
  - Feeders
  - Line Equipment
- **Add New Complaint**: Simple form to register new complaints.
- **View My Complaints**: Track all complaints added by the user, with status (Open, Closed, Pending, etc.).
- **All Pending Complaints**: View all pending complaints in the system.
- **Complaint Details**: View detailed information for each complaint.
- **Change Password**: Secure password update for user accounts.
- **Permissions Handling**: Requests and manages permissions for location and camera.
- **Responsive UI**: Modern, mobile-friendly interface.

## Screenshots

> _Add screenshots of the app here (optional)_

## Requirements

- Flutter SDK >= 3.5.4
- Dart SDK >= 3.5.4
- Android/iOS device or emulator

## Dependencies

- [cupertino_icons](https://pub.dev/packages/cupertino_icons) ^1.0.8
- [intl](https://pub.dev/packages/intl) ^0.20.2
- [animated_custom_dropdown](https://pub.dev/packages/animated_custom_dropdown) ^3.1.1
- [http](https://pub.dev/packages/http) ^1.2.1
- [permission_handler](https://pub.dev/packages/permission_handler) ^11.1.0
- [shared_preferences](https://pub.dev/packages/shared_preferences) ^2.5.3
- [image_picker](https://pub.dev/packages/image_picker) ^1.1.2
- [flutter_image_compress](https://pub.dev/packages/flutter_image_compress) ^2.4.0
- [path_provider](https://pub.dev/packages/path_provider) ^2.1.5
- [path](https://pub.dev/packages/path) ^1.9.1

## Permissions

The app requires the following permissions:
- **Internet Access**: To connect with the server for complaint management.
- **Location Access**: To detect and update the exact location of the complaint area.
- **Camera Access**: To capture images of defective parts for complaints.

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone <repo-url>
   cd mppkvvcl
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure

- `lib/main.dart` - App entry point
- `lib/SRC/screen/` - All main screens (login, home, complaints, etc.)
- `lib/SRC/models/` - Data models
- `lib/SRC/services/` - API and business logic
- `lib/SRC/widgets/` - Reusable UI components
- `assets/` - Images and icons

## Testing

Run widget tests with:
```bash
flutter test
```

## Author

MPPKVVCL Team

Powered by NEXTIN LABS

## License

> _Specify your license here_

## Contact

- [MPPKVVCL Website](https://www.mppkvvcl.in/)
- [Contact Us](https://www.mppkvvcl.in/contact-us)
