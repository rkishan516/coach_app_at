import 'package:flutter/material.dart';
import 'package:shiksha_dhra/app/app.dart';
import 'package:shiksha_dhra/app/common/services/shared_perferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPerferencesServiceProvider.overrideWithValue(sharedPreferences)
      ],
      child: const MainApp(),
    ),
  );
}
