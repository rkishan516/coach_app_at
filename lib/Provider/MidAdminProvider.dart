import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class MidAdminProvider extends ChangeNotifier {
  MidAdminProvider() {
    branches = Map<String, Branch>();
    for (int i = 0; i < AppwriteAuth.instance.branchList.length; i++) {
      FirebaseDatabase.instance
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchList[i]}')
          .onValue
          .listen((event) {
        setBranches(AppwriteAuth.instance.branchList[i].toString(),
            Branch.fromJson(event.snapshot.value as Map));
      });
    }
  }

  late Map<String, Branch> branches;

  setBranches(String k, Branch branch) {
    branches[k] = branch;
    notifyListeners();
  }
}
