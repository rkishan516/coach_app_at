import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    FirebaseDatabase.instance
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}')
        .onValue
        .listen((event) {
      branch = Map<String, Branch>();
      midAdmins = Map<String, MidAdmin>();
      setInstituteDetails(
          event.snapshot.value['name'], event.snapshot.value['paid']);
      if (event.snapshot.value != null) {
        if (event.snapshot.value['branches'] != null) {
          event.snapshot.value['branches'].forEach((k, v) {
            setBranch(k, Branch.fromJson(v));
          });
        }
        if (event.snapshot.value['midAdmin'] != null) {
          event.snapshot.value['midAdmin'].forEach((k, v) {
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
