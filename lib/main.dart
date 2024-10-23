import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:coach_app/SpeechRouting/RouteMap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppwriteAuth.instance.packageInfo = packageInfo;
  AppwriteAuth.instance.prefs = await SharedPreferences.getInstance();

  runApp(
    EasyLocalization(
      path: 'assets/translation',
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
      ],
      saveLocale: true,
      startLocale: Locale('en'),
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Future<SharedPreferences> _getPrefs() async {
    AppwriteAuth.instance.prefs = await SharedPreferences.getInstance();
    final prefs = AppwriteAuth.instance.prefs;
    return prefs!;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return MaterialApp(
      routes: RouteMap().createroute(),
      title: 'Guru Cool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.portLligatSansTextTheme(),
        primarySwatch: MaterialColor(
          0xffF36C24,
          <int, Color>{
            50: Color(0xFFFBE9E7),
            100: Color(0xFFFFCCBC),
            200: Color(0xFFFFAB91),
            300: Color(0xFFFF8A65),
            400: Color(0xFFFF7043),
            500: Color(0xffF36C24),
            600: Color(0xFFF4511E),
            700: Color(0xFFE64A19),
            800: Color(0xFFD84315),
            900: Color(0xFFBF360C),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<SharedPreferences>(
        future: _getPrefs(),
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data!.getBool('isLoggedIn') == true) {
              WelcomeNavigation.signInWithGoogleAndGetPage(context);
              return UploadDialog(warning: 'Logging In'.tr());
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
