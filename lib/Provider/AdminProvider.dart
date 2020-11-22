import 'dart:convert';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    branch = Map<String, Branch>();
    midAdmins = Map<String, MidAdmin>();
    try {
      var p = FireBaseAuth.instance.prefs.getString('AdminData');
      var s;
      if (p != null) {
        s = json.decode(p);
      }
      if (s != null) {
        setInstituteDetails(s['name'], s['paid']);
        if (s['branches'] != null) {
          s['branches'].forEach((k, v) {
            setBranch(k, Branch.fromJson(v));
          });
        }
        if (s['midAdmin'] != null) {
          s['midAdmin'].forEach((k, v) {
            setMidAdmin(k, MidAdmin.fromJson(v));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    FirebaseDatabase.instance
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}')
        .once()
        .asStream()
        .listen((event) {
      FireBaseAuth.instance.prefs
          .setString('AdminData', json.encode(event.value));
      setInstituteDetails(event.value['name'], event.value['paid']);
      if (event.value != null) {
        if (event.value['branches'] != null) {
          event.value['branches'].forEach((k, v) {
            setBranch(k, Branch.fromJson(v));
          });
        }
        if (event.value['midAdmin'] != null) {
          event.value['midAdmin'].forEach((k, v) {
            setMidAdmin(k, MidAdmin.fromJson(v));
          });
        }
      }
    });
  }

  Map<String, Branch> branch;
  Map<String, MidAdmin> midAdmins;
  String instituteName;
  String status;

  setInstituteDetails(String instituteName, String status) {
    this.instituteName = instituteName;
    this.status = status;
    notifyListeners();
  }

  setBranch(String key, Branch branch) {
    this.branch[key] = branch;
    notifyListeners();
  }

  setMidAdmin(String key, MidAdmin midAdmin) {
    this.midAdmins[key] = midAdmin;
    notifyListeners();
  }
}
