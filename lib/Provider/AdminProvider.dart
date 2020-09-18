import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    FirebaseDatabase.instance
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}/branches')
        .onValue
        .listen((event) {
      branch = Map<String, Branch>();
      event.snapshot.value?.forEach((k, v) {
        setBranch(k, Branch.fromJson(v));
      });
    });
    FirebaseDatabase.instance
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}/midAdmin')
        .onValue
        .listen((event) {
      midAdmins = Map<String, MidAdmin>();
      event.snapshot.value?.forEach((k, v) {
        setMidAdmin(k, MidAdmin.fromJson(v));
      });
    });
  }

  Map<String, Branch> branch;
  Map<String, MidAdmin> midAdmins;

  setBranch(String key, Branch branch) {
    this.branch[key] = branch;
    notifyListeners();
  }

  setMidAdmin(String key, MidAdmin midAdmin) {
    this.midAdmins[key] = midAdmin;
    notifyListeners();
  }
}
