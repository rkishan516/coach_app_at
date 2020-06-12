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
            Expanded(flex: 4, child: _title()),
            Expanded(child: Container(), flex: 4),
            Center(
              child: Text(
                'Please re-download the app from Google Play Store',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(child: Container(), flex: 6),
          ],
        ),
      ),
    );
  }
}
