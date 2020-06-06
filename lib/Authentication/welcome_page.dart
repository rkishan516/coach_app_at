import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:coach_app/noInternet/instituteRegister.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
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
            SignInButtonBuilder(
              key: ValueKey("Google"),
              text: 'Sign in with Google',
              textColor: Colors.white,
              image: Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/logos/google_light.png',
                    package: 'flutter_signin_button',
                  ),
                ),
              ),
              backgroundColor: Color(0xfff2905e),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () =>
                  WelcomeNavigation.signInWithGoogleAndGetPage(context),
              innerPadding: EdgeInsets.all(0),
              height: 36.0,
              width: 180,
            ),
            Expanded(child: Container(), flex: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideButton(
                text: 'Register Institute',
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
