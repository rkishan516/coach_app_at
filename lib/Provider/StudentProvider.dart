import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class StudentProvider extends ChangeNotifier {
  StudentProvider() {
    FirebaseDatabase.instance
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}')
        .onValue
        .listen((event) {
      setStudent(Student.fromJson(event.snapshot.value));
    });
  }

  Student student;

  setStudent(Student student) {
    this.student = student;
    notifyListeners();
  }
}
