import 'package:coach_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

class MalFunctionedAPK extends StatelessWidget {
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
                color: GuruCoolLightColor.backgroundShade,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [GuruCoolLightColor.whiteColor, GuruCoolLightColor.primaryColor],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _title()),
            Expanded(child: Container(), flex: 4),
            Center(
              child: Text(
                'Please re-download the app from Google Play Store',
                textAlign: TextAlign.center,
                style: TextStyle(color: GuruCoolLightColor.whiteColor),
              ),
            ),
            Expanded(child: Container(), flex: 6),
          ],
        ),
      ),
    );
  }
}
