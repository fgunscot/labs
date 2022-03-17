import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab0_firebase_tested_base/firebase_options.dart';

import 'package:lab0_firebase_tested_base/src/app.dart';
import 'package:lab0_firebase_tested_base/src/authentication/authentication_controller.dart';
import 'package:lab0_firebase_tested_base/src/authentication/authentication_service.dart';
import 'package:lab0_firebase_tested_base/src/settings/settings_controller.dart';
import 'package:lab0_firebase_tested_base/src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  final AuthenticationController authController =
      AuthenticationController(AuthenticationService());

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(
    settingsController: settingsController,
    authController: authController,
  ));
}
