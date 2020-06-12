import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class StudentPerformance extends StatelessWidget {
  final String uid;
  final String courseId;
  StudentPerformance({@required this.uid, @required this.courseId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Performance'.tr(),
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<Event>(
          stream: FirebaseDatabase.instance
              .reference()
              .child(
                  'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/')
              .onValue,
          builder: (context, snap) {
            if (snap.hasData) {
              Branch branch = Branch.fromJson(snap.data.snapshot.value);
              Map<String, int> subjectPerformance = Map<String, int>();
              snap.data.snapshot
                  .value['students']['$uid']['courses']['$courseId']['subjects']
                  ?.forEach((k, v) {
                double score = 0;
                int count = 0;
                String name;
                v['chapters']?.forEach((k, v) {
                  v['content']?.forEach((k, v) {
                    score += v['score'];
                    count++;
                  });
                });
                branch.courses.forEach((element) {
                  if (element.id == courseId) {
                    name = element.subjects[k].name;
                  }
                });

                subjectPerformance[name] = score * 100 ~/ count;
              });
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: subjectPerformance.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Color(0xffF36C24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(
                          subjectPerformance.keys.toList()[index],
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          '${subjectPerformance[subjectPerformance.keys.toList()[index]]}%',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return UploadDialog(warning: 'Fetching Student Data'.tr());
            }
          }),
    );
  }
}
