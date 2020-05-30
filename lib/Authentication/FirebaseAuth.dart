import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuth {
  static FireBaseAuth instance = FireBaseAuth._();
  FireBaseAuth._();

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  FirebaseUser user;
  var branchid,instituteid;

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.email);
      user.getIdToken(refresh: true).then((value) {
        print('...................');
        print(value.claims);
        branchid = value.claims['branchid'];
        instituteid = value.claims['instituteid'];
      });

      this.user = user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signoutWithGoogle() async {
    try {
      await _auth.signOut();
      user = null;
    } catch (e) {
      print(e.message);
    }
  }
}
