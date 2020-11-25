import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/malfunctionedApk.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/NewAuthentication/Backened/Wrapper.dart';
import 'package:coach_app/SpeechRouting/RouteMap.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:in_app_update/in_app_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  FireBaseAuth.instance.packageInfo = packageInfo;
  FireBaseAuth.instance.prefs = await SharedPreferences.getInstance();
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  if (packageInfo.packageName != "com.VysionTech.gurucool") {
    runApp(MaterialApp(
      title: 'Guru Cool',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        textTheme: GoogleFonts.portLligatSansTextTheme(),
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      theme: ThemeData(
        textTheme: GoogleFonts.portLligatSansTextTheme(),
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MalFunctionedAPK(),
    ));
    return;
  }
  // InAppUpdate.checkForUpdate().then((value) {
  //   if (value.updateAvailable) {
  //     InAppUpdate.startFlexibleUpdate().then((value) {
  //       InAppUpdate.completeFlexibleUpdate()
  //           .then((value) {})
  //           .catchError((e) => {print(e)});
  //     }).catchError((e) => {print(e)});
  //   }
  // }).catchError((e) => {print(e)});

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
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return StreamProvider<AppUser>.value(
      value: FireBaseAuth.instance.appuser,
      child: MaterialApp(
        routes: RouteMap().createroute(),
        title: 'Guru Cool',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.portLligatSansTextTheme(),
          primarySwatch: GuruCoolLightColor.primarySwatch,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
