import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
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
        await Future.delayed(Duration(seconds: 10));
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
  }

  Future<void> signoutWithGoogle() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (user != null) {
        prefs.remove('isLoggedIn');
      }
      await _auth.signOut();
      await _googleSignIn.signOut();
      user = null;
    } catch (e) {
      print(e.message);
    }
  }
}
