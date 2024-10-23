import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:coach_app/Events/FirebaseMessaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

final client = Client()
    .setEndpoint("https://cloud.appwrite.io/v1")
    .setProject("<YOUR_PROJECT_ID>");

class AppwriteAuth {
  static AppwriteAuth instance = AppwriteAuth._();
  AppwriteAuth._();

  Account _auth = Account(client);

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  PackageInfo? packageInfo;
  User? user;
  SharedPreferences? prefs;
  String? branchid, instituteid;
  List<int> branchList = [];
  int previlagelevel = -1;

  Future<List<String>> getAuthGCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') == true) {
      GoogleSignInAccount? googleUser =
          await _googleSignIn.signInSilently(suppressErrors: true);
      if (googleUser == null) return [];
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      return [googleAuth.accessToken!, googleAuth.idToken!];
    } else {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return [];
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      prefs.setString('credA', googleAuth.accessToken!);
      prefs.setString('credI', googleAuth.idToken!);
      return [googleAuth.accessToken!, googleAuth.idToken!];
    }
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      User? currUser = await _auth.get();
      this.user = currUser;

      print("signed in " + user!.email);

      if (user != null) {
        prefs?.setBool('isLoggedIn', true);
      }
      await updateClaims();
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  updateClaims() async {
    final preferences = await _auth.getPrefs();
    branchid = preferences.data['branchid'];
    instituteid = preferences.data['instituteid'];
    previlagelevel = preferences.data['previlagelevel'];
    if (previlagelevel == 34) {
      branchList =
          JsonCodec().decode(JsonCodec().decode(branchid!)).cast<int>();
    }
    updateToken();
  }

  updateToken() {
    FirebaseMessagingService()
        .sendNotification(); // initializing messaging handlers
    FirebaseMessagingService().flutterlocalnotificationplugin.cancelAll();

    FirebaseMessaging.instance.getToken().then((token) {
      final dbref = FirebaseDatabase.instance
          .ref()
          .child('institute/${AppwriteAuth.instance.instituteid}/');
      if (previlagelevel == 1) {
        dbref
            .child(
                'branches/${AppwriteAuth.instance.branchid}/students/${AppwriteAuth.instance.user!.$id}/tokenid')
            .set(token.toString());
      } else if (previlagelevel == 2) {
        dbref
            .child(
                'branches/${AppwriteAuth.instance.branchid}/teachers/${AppwriteAuth.instance.user!.$id}/tokenid')
            .set(token.toString());
      } else if (previlagelevel == 3) {
        dbref
            .child(
                'branches/${AppwriteAuth.instance.branchid}/admin/${user!.$id}/tokenid')
            .set(token.toString());
      } else if (previlagelevel == 4) {
        dbref
            .child('admin/${AppwriteAuth.instance.user!.$id}/tokenid')
            .set(token.toString());
      } else if (previlagelevel == 34) {
        dbref
            .child("midAdmin/${AppwriteAuth.instance.user!.$id}/tokenid")
            .set(token.toString());
      }
    });
  }

  Future<void> signoutWithGoogle() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await _auth.deleteSession(sessionId: 'current');
      await _googleSignIn.signOut();
      user = null;
    } catch (e) {
      print(e);
    }
  }
}
