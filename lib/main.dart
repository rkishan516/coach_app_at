import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:coach_app/YT_player/ad_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(
    EasyLocalization(
      path: 'assets/translation',
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
      ],
      saveLocale: true,
      fallbackLocale: Locale('hi'),
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
      // localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.portLligatSansTextTheme(),
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _getPrefs(),
        builder: (context, snap) {
          if (snap.hasData) {
            if (prefs?.getBool('isLoggedIn') == true) {
              return FlareLoading(
                name: 'assets/images/gurucool.flr',
                onSuccess: (_) {},
                onError: (_, __) {},
                startAnimation: 'animation',
                until: () =>
                    WelcomeNavigation.signInWithGoogleAndGetPage(context),
              );
            }
            return WelcomePage();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
