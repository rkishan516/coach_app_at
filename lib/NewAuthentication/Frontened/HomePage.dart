
import 'package:coach_app/NewAuthentication/Frontened/NewWelcomePage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Center(
        child: RaisedButton(
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewWelcomePage()));
          },
          child: Text('Take me to Login Page'),
           )),

      );
  }
}