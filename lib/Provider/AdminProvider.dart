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
      event.snapshot.value?.forEach((k, v) {
        setBranch(k, Branch.fromJson(v));
      });
    });
  }

  Map<String, Branch> branch;

  setBranch(String key, Branch branch) {
    this.branch[key] = branch;
    notifyListeners();
  }
}
