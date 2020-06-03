import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:coach_app/noInternet/noInternet.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences prefs;
  _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  Widget build(BuildContext context) {
     initializeDateFormatting();
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
              return FutureBuilder(
                future: _getPrefs(),
                builder: (context, snap) {
                  if (snapshot.hasData) {
                    if (prefs?.getBool('isLoggedIn') == true) {
                      WelcomeNavigation.signInWithGoogleAndGetPage(context);
                      return Container();
                    }
                    return WelcomePage();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            } else {
              return Scaffold(
                body:
                    Center(child: Text('Internet Connectivity Checking').tr()),
              );
            }
          }),
    );
  }
}
