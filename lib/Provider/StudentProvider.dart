import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class StudentProvider extends ChangeNotifier {
  StudentProvider() {
    FirebaseDatabase.instance
        .ref()
        .child(
            'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/students/${AppwriteAuth.instance.user!.$id}')
        .onValue
        .listen((event) {
      setStudent(Student.fromJson(event.snapshot.value as Map));
    });
  }

  late Student student;

  setStudent(Student student) {
    this.student = student;
    notifyListeners();
  }
}
