import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:coach_app/noInternet/instituteRegister.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _title() {
    return Image.asset('assets/images/logo.png');
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _skey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _skey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xffF36C24)],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(flex: 3, child: _title()),
            Expanded(child: Container(), flex: 4),
            InkWell(
              onTap: () =>
                  WelcomeNavigation.signInWithGoogleAndGetPage(context),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Color(0xfff2905e),
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/logos/google_light.png',
                          package: 'flutter_signin_button',
                        ),
                      ),
                    ),
                    Text('Sign in with Google'.tr(),style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
            Expanded(child: Container(), flex: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideButton(
                text: 'Register Institute'.tr(),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => InstituteRegister(),
                    ),
                  );
                },
                width: 180,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
