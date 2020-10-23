import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:coach_app/NewAuthentication/Backened/Alertmessage.dart';

import 'package:coach_app/NewAuthentication/Backened/Wait.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Wrapper2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireBaseAuth.instance.testing(context),
      builder:(context, snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.hasData){
          FirebaseUser user = snapshot.data;
          if(user.isEmailVerified)
          return WelcomeNavigation.getPage(context, user.uid);
          else
          return AlertMessage();
          }
          return Wait();
        }
        else{
          return Wait();
        }
      } 
    
    );
  }
}