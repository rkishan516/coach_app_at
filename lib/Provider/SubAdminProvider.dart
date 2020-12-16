import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class SubAdminProvider extends ChangeNotifier {
  SubAdminProvider() {
    FirebaseDatabase.instance
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/')
        .onValue
        .listen((event) {
      setBranch(Branch.fromJson(event.snapshot.value));
    });
  }

  Branch branch;

  setBranch(Branch branch) {
    this.branch = branch;
    notifyListeners();
  }
}
