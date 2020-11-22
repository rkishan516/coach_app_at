import 'dart:async';
import 'dart:convert';

import 'package:coach_app/Events/FirebaseMessaging.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseAuth {
  static FireBaseAuth instance = FireBaseAuth._();
  FireBaseAuth._();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currentuser;
  String providerid;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  PackageInfo packageInfo;
  FirebaseUser user;
  SharedPreferences prefs;
  var branchid, instituteid, previlagelevel, branchList;

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
    print('here');
    try {
      FirebaseUser currUser = await FirebaseAuth.instance.currentUser();
      if (currUser != null) {
        this.user = currUser;
      } else {
        var creds = await getAuthGCredentials();

        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: creds[0],
          idToken: creds[1],
        );
        final AuthResult authResult =
            (await _auth.signInWithCredential(credential));
        this.user = authResult.user;
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
      }

      print("signed in " + user.email);

      // if (user != null) {
      //   prefs.setBool('isLoggedIn', true);
      // }
      await updateClaims();
      print(user);
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
    if (previlagelevel == 34) {
      branchList = JsonCodec().decode(JsonCodec().decode(branchid)).cast<int>();
    }
    updateToken();
  }

  updateToken() {
    FirebaseMessagingService()
        .sendNotification(); // initializing messaging handlers
    FirebaseMessagingService().flutterlocalnotificationplugin.cancelAll();

    FirebaseMessaging().getToken().then((token) {
      final dbref = FirebaseDatabase.instance
          .reference()
          .child('institute/${FireBaseAuth.instance.instituteid}/');
      if (previlagelevel == 1) {
        dbref
            .child(
                'branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/tokenid')
            .set(token.toString());
      } else if (previlagelevel == 2) {
        dbref
            .child(
                'branches/${FireBaseAuth.instance.branchid}/teachers/${FireBaseAuth.instance.user.uid}/tokenid')
            .set(token.toString());
      } else if (previlagelevel == 3) {
        dbref
            .child(
                'branches/${FireBaseAuth.instance.branchid}/admin/${user.uid}/tokenid')
            .set(token.toString());
      } else if (previlagelevel == 4) {
        dbref
            .child('admin/${FireBaseAuth.instance.user.uid}/tokenid')
            .set(token.toString());
      } else if (previlagelevel == 34) {
        dbref
            .child("midAdmin/${FireBaseAuth.instance.user.uid}/tokenid")
            .set(token.toString());
      }
    });
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

  Future<FirebaseUser> testing(BuildContext context) async {
    try {
      providerid = (await FirebaseAuth.instance.currentUser()).providerId;
      if (providerid == "password") {
        AuthResult credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: prefs.getString("Email"),
                password: prefs.getString("Pass"));
        await _flareloading(credential, context);
        return credential.user;
      } else {
        return await FireBaseAuth.instance.signInWithGoogle(context);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  _userFromFirebaseuser(FirebaseUser user) {
    return user != null
        ? AppUser(
            uid: user.uid,
            name: user.displayName,
            isEmailVerfied: user.isEmailVerified)
        : null;
  }

  Stream<AppUser> get appuser {
    return _auth.onAuthStateChanged.map((user) => _userFromFirebaseuser(user));
  }

  Future<String> signIn(
      String email, String password, BuildContext context) async {
    try {
      AuthResult credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      currentuser = credential.user;
      await _flareloading(credential, context);
      return "";
    } catch (e) {
      print(e);
      return e.message;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> signUp(
      String email, String password, String name, BuildContext context) async {
    try {
      AuthResult credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      currentuser = credential.user;
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = name;
      await currentuser.updateProfile(info);
      await currentuser.reload();
      await _flareloading(credential, context);
    } catch (e) {
      print(e);
      return e.message;
    }
    try {
      await currentuser.sendEmailVerification();
      return "";
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e);
      return e.message;
    }
  }

  _flareloading(AuthResult credential, BuildContext context) async {
    if (credential.additionalUserInfo.isNewUser) {
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
    print("signed in " + user.email);

    await updateClaims();
  }
}
