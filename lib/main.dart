import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/malfunctionedApk.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  FireBaseAuth.instance.packageInfo = packageInfo;
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  if (packageInfo.packageName != "com.VysionTech.gurucool") {
    runApp(MaterialApp(
      title: 'Guru Cool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.portLligatSansTextTheme(),
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MalFunctionedAPK(),
    ));
    return;
  }
  InAppUpdate.checkForUpdate().then((value) {
    if (value.updateAvailable) {
      InAppUpdate.startFlexibleUpdate().then((value) {
        InAppUpdate.completeFlexibleUpdate().then((value) {
          print('Updated Successfully');
        }).catchError(
            (e) => print('completeFlexibleUpdateError : ' + e.toString()));
      }).catchError((e) => print('startFlexibleUpdateError : ' + e.toString()));
    }
    print(value);
  }).catchError((e) => print('checkUpdateError : ' + e.toString()));

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
      home: FutureBuilder(
        future: _getPrefs(),
        builder: (context, snap) {
          if (snap.hasData) {
            if (prefs?.getBool('isLoggedIn') == true) {
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
