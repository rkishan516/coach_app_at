import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    FirebaseDatabase.instance
        .ref()
        .child('institute/${AppwriteAuth.instance.instituteid}')
        .onValue
        .listen((event) {
      branch = Map<String, Branch>();
      midAdmins = Map<String, MidAdmin>();

      Map? data = event.snapshot.value as Map?;
      setInstituteDetails(
        data?['name'],
        data?['paid'],
      );
      if (data != null) {
        if (data['branches'] != null) {
          data['branches'].forEach((k, v) {
            setBranch(k, Branch.fromJson(v));
          });
        }
        if (data['midAdmin'] != null) {
          data['midAdmin'].forEach((k, v) {
            setMidAdmin(k, MidAdmin.fromJson(v));
          });
        }
      }
    });
  }

  late Map<String, Branch> branch;
  late Map<String, MidAdmin> midAdmins;
  late String instituteName;
  late String status;

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
