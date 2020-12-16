import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class TeacherProvider extends ChangeNotifier {
  TeacherProvider() {
    FirebaseDatabase.instance
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers/${FireBaseAuth.instance.user.uid}")
        .onValue
        .listen((event) {
      setTeacher(Teacher.fromJson(event.snapshot.value));
    });
  }

  Teacher teacher;

  setTeacher(Teacher teacher) {
    this.teacher = teacher;
    notifyListeners();
  }
}
