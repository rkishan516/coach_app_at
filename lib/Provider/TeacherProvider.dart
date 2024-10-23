import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class TeacherProvider extends ChangeNotifier {
  TeacherProvider() {
    FirebaseDatabase.instance
        .ref()
        .child(
            "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/teachers/${AppwriteAuth.instance.user!.$id}")
        .onValue
        .listen((event) {
      setTeacher(Teacher.fromJson(event.snapshot.value as Map));
    });
  }

  late Teacher teacher;

  setTeacher(Teacher teacher) {
    this.teacher = teacher;
    notifyListeners();
  }
}
