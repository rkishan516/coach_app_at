import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/WaitScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InstallMentList extends StatefulWidget {
  final DatabaseReference ref;
  final String courseID;
  InstallMentList({
    required this.ref,
    required this.courseID,
  });
  @override
  _InstallMentListState createState() => _InstallMentListState();
}

class _InstallMentListState extends State<InstallMentList> {
  bool paidOneTime = true;
  List<bool> installments = [];
  registerStudent() {
    RequestedCourseFee requestedCourseFee = RequestedCourseFee(
        isPaidOneTime: paidOneTime, installments: installments);
    widget.ref.parent!.parent!
        .child('/students/${AppwriteAuth.instance.user!.$id}/class')
        .set(widget.courseID);
    widget.ref.parent!.parent!
        .child('/students/${AppwriteAuth.instance.user!.$id}/status')
        .set('Existing Student');
    widget.ref.parent!.parent!
        .child(
            '/students/${AppwriteAuth.instance.user!.$id}/requestedCourseFee')
        .update(requestedCourseFee.toJson());
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return WaitScreen();
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Installments',
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<DatabaseEvent>(
            stream: widget.ref.child("fees").onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.data!.snapshot.value == null) {
                return Center(child: Text('No Payment Option Available'));
              }
              if (installments == null &&
                  (snapshot.data!.snapshot.value as Map)['MaxInstallment']
                      ['IsMaxAllowed']) {
                installments = <bool>[];
                for (int i = 0;
                    i <
                        int.parse((snapshot.data!.snapshot.value
                            as Map)['MaxInstallment']['MaxAllowedInstallment']);
                    i++) {
                  installments.add(false);
                }
              }
              if ((snapshot.data!.snapshot.value as Map)['OneTime']
                      ['IsOneTimeAllowed'] &&
                  (snapshot.data!.snapshot.value as Map)['MaxInstallment']
                      ['IsMaxAllowed']) {
              } else {
                paidOneTime = (snapshot.data!.snapshot.value as Map)['OneTime']
                    ['IsOneTimeAllowed'];
              }
              return ListView(
                children: [
                  if ((snapshot.data!.snapshot.value as Map)['OneTime']
                      ['IsOneTimeAllowed'])
                    SwitchListTile.adaptive(
                      title: Text('Paid One Time'),
                      value: paidOneTime,
                      onChanged: ((snapshot.data!.snapshot.value
                                  as Map)['OneTime']['IsOneTimeAllowed'] &&
                              (snapshot.data!.snapshot.value
                                  as Map)['MaxInstallment']['IsMaxAllowed'])
                          ? (val) {
                              setState(() {
                                paidOneTime = !paidOneTime;
                              });
                            }
                          : null,
                    ),
                  if ((snapshot.data!.snapshot.value as Map)['MaxInstallment']
                      ['IsMaxAllowed'])
                    SwitchListTile.adaptive(
                      title: Text('Paid In Installments'),
                      value: !paidOneTime,
                      onChanged: ((snapshot.data!.snapshot.value
                                  as Map)['OneTime']['IsOneTimeAllowed'] &&
                              (snapshot.data!.snapshot.value
                                  as Map)['MaxInstallment']['IsMaxAllowed'])
                          ? (val) {
                              setState(() {
                                paidOneTime = !paidOneTime;
                              });
                            }
                          : null,
                    ),
                  if (!paidOneTime)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: int.parse((snapshot.data!.snapshot.value
                          as Map)['MaxInstallment']['MaxAllowedInstallment']),
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text('Installment ${index + 1}'),
                          value: installments[index],
                          onChanged: (val) {
                            setState(
                              () {
                                if (val == true) {
                                  for (int i = 0; i <= index; i++) {
                                    installments[i] = true;
                                  }
                                } else {
                                  for (int i = index;
                                      i <
                                          int.parse(
                                              (snapshot.data!.snapshot.value
                                                      as Map)['MaxInstallment']
                                                  ['MaxAllowedInstallment']);
                                      i++) {
                                    installments[i] = false;
                                  }
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  MaterialButton(
                    color: Color(0xffF36C24),
                    onPressed: registerStudent,
                    child: Text(
                      'Request For Access',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
