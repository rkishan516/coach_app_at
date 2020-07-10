import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class MidAdminProvider extends ChangeNotifier {
  
  MidAdminProvider() {
    List<Branch> brancehs = List<Branch>();
    for (int i = 0; i < FireBaseAuth.instance.branchList.length; i++) {
      FirebaseDatabase.instance
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchList[i]}')
          .onValue
          .listen((event) {
        branches.add(Branch.fromJson(event.snapshot.value));
      });
    }
    setBranches(brancehs);
  }

  List<Branch> branches;

  setBranches(List<Branch> brancehs) {
    this.branches = branches;
    notifyListeners();
  }
}
