import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/FeeSection/Fragments/DiscountReport.dart';
import 'package:coach_app/FeeSection/Fragments/DueFeeReport.dart' as dfr;
import 'package:coach_app/FeeSection/Fragments/FineReport.dart';
import 'package:coach_app/FeeSection/Fragments/OneTimePaid.dart';
import 'package:coach_app/FeeSection/Fragments/PaidReport.dart';
import 'package:coach_app/FeeSection/Fragments/PaymentReport.dart';
import 'package:coach_app/FeeSection/Fragments/StudentModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FeeReport extends StatelessWidget {
  final String type;
  FeeReport({@required this.type});

  _getReportFragment(String position, var _listStudentModel) {
    switch (position) {
      case "Payment Report":
        return PayementReport(_listStudentModel);
        break;
      case "Due Fee Report":
        return dfr.DueFeeReport(_listStudentModel);
        break;
      case "Discount Report":
        return DiscountReport(_listStudentModel);
        break;
      case "Fine Report":
        return FineReport(_listStudentModel);
        break;
      case "Paid Report":
        return PaidReport(_listStudentModel);
        break;
      case "OneTime Paid Report":
        return OneTimeReport(_listStudentModel);
        break;
      default:
        return "Error Ocurred";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Text('$type Fee Report'),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: StreamBuilder<Event>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child(
                          "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList")
                      .onValue,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return UploadDialog(warning: 'Fetching');
                    }
                    Map<String, String> courses = Map<String, String>();
                    snapshot.data.snapshot.value.forEach((key, value) {
                      courses[key] = value;
                    });
                    return GridView.builder(
                      itemCount: courses.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${courses[courses.keys.toList()[index]]}'),
                                ),
                                Divider(
                                  thickness: 2,
                                  height: 5,
                                  color: Color(
                                    0xffF36C24,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: StreamBuilder<Event>(
                                      stream: FirebaseDatabase.instance
                                          .reference()
                                          .child(
                                              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students")
                                          .orderByChild(
                                              "course/${courses.keys.toList()[index]}/courseID")
                                          .equalTo(
                                              "${courses.keys.toList()[index]}")
                                          .onValue,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }
                                        return StreamBuilder<Event>(
                                          stream: FirebaseDatabase.instance
                                              .reference()
                                              .child(
                                                  "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${courses.keys.toList()[index]}/fees")
                                              .onValue,
                                          builder: (context, snapshots) {
                                            if (!snapshots.hasData) {
                                              return Container();
                                            }
                                            List<StudentModel> _list = [];
                                            snapshot.data.snapshot.value
                                                ?.forEach((key, value) {
                                              if (value["course"][
                                                          "${courses.keys.toList()[index]}"]
                                                      ["fees"] !=
                                                  null)
                                                _list.add(
                                                  StudentModel.fromJSON(
                                                    key,
                                                    value,
                                                    snapshots
                                                        .data.snapshot.value,
                                                    "${courses.keys.toList()[index]}",
                                                  ),
                                                );
                                            });
                                            return Column(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: _getReportFragment(
                                                    type,
                                                    _list,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0,
                                                            top: 4.0,
                                                            bottom: 4.0),
                                                    child: RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return Scaffold(
                                                                appBar: AppBar(
                                                                  title: Text(
                                                                      type),
                                                                ),
                                                                body:
                                                                    _getReportFragment(
                                                                        type,
                                                                        _list),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      color: Color(0xffF36C24),
                                                      child: Center(
                                                        child: Text(
                                                          'See Full List',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
