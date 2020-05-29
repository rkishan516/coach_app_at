import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:coach_app/XD_Screens/XD_AndroidMobile20.dart';
import 'package:coach_app/noInternet/noInternet.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
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
      home: StreamBuilder<ConnectivityStatus>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == ConnectivityStatus.none) {
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
