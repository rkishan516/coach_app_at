import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Student/registration_form.dart';
import 'package:coach_app/noInternet/noInternet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    EasyLocalization(
      path: 'assets/translation',
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guru Cool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.portLligatSansTextTheme(),
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == ConnectivityResult.none) {
                return NoInternet();
              }
              return WelcomePage();
            } else {
              return Scaffold(
                body: Center(child: Text('Internet Connectivity Checking').tr()),
              );
            }
          }),
    );
  }
}
