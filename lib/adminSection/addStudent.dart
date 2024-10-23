import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  final String? courseId;
  AddStudent({this.courseId});
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  late TextEditingController emailTextEditingController,
      nameTextEditingController,
      addressTextEditingController,
      phoneTextEditingController;
  late String courseName;
  String? courseId;
  late bool isPaidOneTime;
  late Courses selectedCourse;
  late List<bool> installments;
  late GlobalKey<FormState> _formKey;

  paidOneTime(double totalfees, String duration, String date, String courseId,
      String studentUid) async {
    await FirebaseDatabase.instance
        .ref()
        .child(
            "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/students/$studentUid/course/$courseId/fees/")
        .update({
      "Installments": {
        "OneTime": {
          "Amount": totalfees,
          "Duration": duration,
          "Status": "Paid",
          "PaidTime": date,
          "Fine": "",
          "PaidInstallment": "",
          "PaidFine": "",
        },
        "AllowedThrough": "OneTime",
        "LastPaidInstallment": "OneTime"
      }
    });
  }

  _updateList(
    List<bool> paidInstallment,
    Map<String, Installment> _listInstallment,
    String courseId,
    String studentUid,
    String date,
  ) async {
    var keys = _listInstallment.keys.toList()..sort();
    String lastPaid = "";

    for (int i = 0; i < _listInstallment.length; i++) {
      if (i < paidInstallment.length ? !paidInstallment[i] : false) {
        FirebaseDatabase.instance
            .ref()
            .child(
                "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/students/$studentUid/course/$courseId/fees/Installments")
            .update(
          {
            keys[i]: {
              "Amount":
                  (double.parse(_listInstallment[keys[i]]!.amount)).toString(),
              "Duration": _listInstallment[keys[i]]!.duration,
              "Status": "Due",
              "PaidTime": "",
              "Fine": ""
            },
            "AllowedThrough": "Installments",
            "LastPaidInstallment": lastPaid,
          },
        );
      } else {
        lastPaid = keys[i];
        FirebaseDatabase.instance
            .ref()
            .child(
                "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/students/$studentUid/course/$courseId/fees/Installments")
            .update(
          {
            keys[i]: {
              "Amount": _listInstallment[keys[i]]!.amount,
              "Duration": _listInstallment[keys[i]]!.duration,
              "Status": "Paid",
              "PaidTime": date,
              "Fine": ""
            },
            "AllowedThrough": "Installments",
            "LastPaidInstallment": keys[i]
          },
        );
      }
    }
  }

  @override
  void initState() {
    emailTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
    phoneTextEditingController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(
                  16.0,
                ),
                margin: EdgeInsets.only(top: 66.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            controller: nameTextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              hintText: 'Name',
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            controller: emailTextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.length != 10) {
                                return "Invalid Mobile No.";
                              }
                              return null;
                            },
                            controller: phoneTextEditingController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              hintText: 'Phone No',
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            controller: addressTextEditingController,
                            decoration: InputDecoration(
                              hintText: 'Address',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (widget.courseId == null)
                      StreamBuilder<DatabaseEvent>(
                          stream: FirebaseDatabase.instance
                              .ref()
                              .child(
                                  'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses')
                              .onValue,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            Map<String, Courses> courses =
                                Map<String, Courses>();
                            (snapshot.data!.snapshot.value as Map?)
                                ?.forEach((k, v) {
                              courses[k] = Courses.fromJson(v);
                            });
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Color(0xfff3f3f4),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                      value: courseId,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 42,
                                      underline: SizedBox(),
                                      onChanged: (String? newValue) {
                                        if (newValue == null) return;
                                        setState(() {
                                          courseId = newValue;
                                          courseName = courses[courseId]!.name;
                                        });
                                      },
                                      hint: Text(
                                        'Select Course',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      items: courses.values
                                          .map<DropdownMenuItem<String>>(
                                              (Courses value) {
                                        return DropdownMenuItem<String>(
                                          value: value.id,
                                          child: Text(value.name),
                                        );
                                      }).toList()),
                                ),
                              ),
                            );
                          }),
                    if (widget.courseId != null || courseId != null)
                      StreamBuilder<DatabaseEvent>(
                          stream: FirebaseDatabase.instance
                              .ref()
                              .child(
                                  'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/${widget.courseId ?? courseId}')
                              .onValue,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            selectedCourse = Courses.fromJson(
                                snapshot.data!.snapshot.value as Map);
                            return ListView(
                              shrinkWrap: true,
                              controller: ScrollController(),
                              children: [
                                if (selectedCourse
                                        .fees?.oneTime.isOneTimeAllowed ??
                                    false)
                                  SwitchListTile.adaptive(
                                    title: Text('Paid One Time'),
                                    value: isPaidOneTime,
                                    onChanged: ((selectedCourse.fees?.oneTime
                                                    .isOneTimeAllowed ??
                                                false) &&
                                            (selectedCourse.fees?.maxInstallment
                                                    .isMaxAllowed ??
                                                false))
                                        ? (val) {
                                            setState(() {
                                              isPaidOneTime = !isPaidOneTime;
                                            });
                                          }
                                        : null,
                                  ),
                                if (selectedCourse
                                        .fees?.maxInstallment.isMaxAllowed ??
                                    false)
                                  SwitchListTile.adaptive(
                                    title: Text('Paid In Installments'),
                                    value: !isPaidOneTime,
                                    onChanged: ((selectedCourse.fees?.oneTime
                                                    .isOneTimeAllowed ??
                                                false) &&
                                            (selectedCourse.fees?.maxInstallment
                                                    .isMaxAllowed ??
                                                false))
                                        ? (val) {
                                            setState(() {
                                              isPaidOneTime = !isPaidOneTime;
                                            });
                                          }
                                        : null,
                                  ),
                                if (!(isPaidOneTime) &&
                                    (selectedCourse.fees?.maxInstallment
                                            .isMaxAllowed ??
                                        false))
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: int.parse(selectedCourse
                                            .fees
                                            ?.maxInstallment
                                            .maxAllowedInstallment ??
                                        "0"),
                                    itemBuilder: (context, index) {
                                      return CheckboxListTile(
                                        title: Text('Installment ${index + 1}'),
                                        value: installments[index],
                                        onChanged: (val) {
                                          setState(
                                            () {
                                              if (val == true) {
                                                for (int i = 0;
                                                    i <= index;
                                                    i++) {
                                                  installments[i] = true;
                                                }
                                              } else {
                                                for (int i = index;
                                                    i < installments.length;
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
                              ],
                            );
                          }),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () async {
                              if (emailTextEditingController.text == '' ||
                                  nameTextEditingController.text == '' ||
                                  addressTextEditingController.text == '' ||
                                  (widget.courseId == null &&
                                      courseId == null) ||
                                  phoneTextEditingController.text == '') {
                                Alert.instance
                                    .alert(context, 'Something is wrong');
                                return;
                              }
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              if (widget.courseId != null) {
                                final snapShot = await FirebaseDatabase.instance
                                    .ref()
                                    .child(
                                        'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/${widget.courseId}/name')
                                    .once();
                                courseName = snapShot.snapshot.value.toString();
                              }
                              if (!emailTextEditingController.text
                                  .endsWith('@gmail.com')) {
                                Alert.instance.alert(
                                    context, 'Only Gmail account allowed');
                                return;
                              }

                              if (emailTextEditingController.text !=
                                  AppwriteAuth.instance.user!.email) {
                                FirebaseFirestore.instance
                                    .collection('institute')
                                    .doc(emailTextEditingController.text
                                        .split('@')[0])
                                    .set({
                                  "value":
                                      "student_${AppwriteAuth.instance.instituteid}_${AppwriteAuth.instance.branchid}"
                                });
                              }
                              DatabaseReference databaseReference = FirebaseDatabase
                                  .instance
                                  .ref()
                                  .child(
                                      'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/students')
                                  .push();
                              databaseReference.update(Student(
                                name: nameTextEditingController.text,
                                email: emailTextEditingController.text,
                                phoneNo: phoneTextEditingController.text,
                                address: addressTextEditingController.text,
                                photoURL: '',
                                course: {
                                  (widget.courseId ?? courseId)!: Course(
                                    academicYear: DateTime.now()
                                            .year
                                            .toString() +
                                        " - " +
                                        (DateTime.now().year + 1).toString(),
                                    courseID: (widget.courseId ?? courseId)!,
                                    courseName: courseName,
                                    paymentToken:
                                        "Registered By ${AppwriteAuth.instance.user!.name}",
                                  ),
                                },
                                status: 'Registered',
                              ).toJson());
                              DateTime dateTime = DateTime.now();
                              String dd = dateTime.day.toString().length == 1
                                  ? "0" + dateTime.day.toString()
                                  : dateTime.day.toString();
                              String mm = dateTime.month.toString().length == 1
                                  ? "0" + dateTime.month.toString()
                                  : dateTime.month.toString();
                              String yyyy = dateTime.year.toString();
                              String date = dd + " " + mm + " " + yyyy;
                              if ((selectedCourse
                                          .fees?.oneTime.isOneTimeAllowed ??
                                      false) &&
                                  (isPaidOneTime)) {
                                paidOneTime(
                                    double.parse(selectedCourse
                                        .fees!.feeSection.totalFees),
                                    (selectedCourse.fees!.oneTime.duration),
                                    (date),
                                    selectedCourse.id,
                                    databaseReference.key!);
                              } else if (!(isPaidOneTime) &&
                                  (selectedCourse
                                          .fees?.maxInstallment.isMaxAllowed ??
                                      false)) {
                                _updateList(
                                    installments,
                                    selectedCourse
                                        .fees!.maxInstallment.installment,
                                    selectedCourse.id,
                                    databaseReference.key!,
                                    date);
                              }
                              Navigator.of(context).pop();
                            },
                            color: Colors.white,
                            child: Text(
                              'Add Student',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
