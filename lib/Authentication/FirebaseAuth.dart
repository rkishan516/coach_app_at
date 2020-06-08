import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseAuth {
  static FireBaseAuth instance = FireBaseAuth._();
  FireBaseAuth._();

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  FirebaseUser user;
  var branchid, instituteid, previlagelevel;

  Future<List<String>> getAuthGCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') == true) {
      final GoogleSignInAccount googleUser =
          await _googleSignIn.signInSilently(suppressErrors: true);
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      return [googleAuth.accessToken, googleAuth.idToken];
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      prefs.setString('credA', googleAuth.accessToken);
      prefs.setString('credI', googleAuth.idToken);
      return [googleAuth.accessToken, googleAuth.idToken];
    }
  }

  Future<FirebaseUser> signInWithGoogle(BuildContext context) async {
    try {
      var creds = await getAuthGCredentials();
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: creds[0],
        idToken: creds[1],
      );
      final AuthResult authResult =
          (await _auth.signInWithCredential(credential));
      final FirebaseUser user = authResult.user;
      print("signed in " + user.email);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (user != null) {
        prefs.setBool('isLoggedIn', true);
      }
      if (authResult.additionalUserInfo.isNewUser) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FlareLoading(
              name: 'assets/images/gurucool.flr',
              onSuccess: (_) {
                Navigator.pop(context);
              },
              onError: (_, __) {},
              startAnimation: 'animation',
              until: () => Future.delayed(Duration(seconds: 10)),
            ),
          ),
        );
      }
      this.user = user;
      await updateClaims();
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  updateClaims() async {
    IdTokenResult idTokenResult = await user.getIdToken(refresh: true);
    branchid = idTokenResult.claims['branchid'];
    instituteid = idTokenResult.claims['instituteid'];
    previlagelevel = idTokenResult.claims['previlagelevel'];
    print(previlagelevel);
  }

  Future<void> signoutWithGoogle() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs?.clear();
      await _auth.signOut();
      await _googleSignIn.signOut();
      user = null;
    } catch (e) {
      print(e.message);
    }
  }
}
