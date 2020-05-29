import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

getDrawer(BuildContext context) {
  FirebaseUser user = FireBaseAuth.instance.user;
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(user.displayName),
          accountEmail: Text(
            user.email,
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl),
          ),
        ),
        ListTile(
          title: Text('Log Out'),
          leading: Icon(Icons.exit_to_app),
          onTap: (){
            FireBaseAuth.instance.signoutWithGoogle().then((value){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> WelcomePage()), (route) => false);
            });
            
          },
        )
      ],
    ),
  );
}
