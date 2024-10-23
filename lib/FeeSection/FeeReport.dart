import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Fragments/DiscountReport.dart';
import 'Fragments/DueFeeReport.dart';
import 'Fragments/FineReport.dart';
import 'Fragments/OneTimePaid.dart';
import 'Fragments/PaidReport.dart';
import 'Fragments/PaymentReport.dart';
import 'Fragments/StudentModel.dart';

class FeesReport extends StatefulWidget {
  final String courseId;
  FeesReport({required this.courseId});
  @override
  _FlutterreportState createState() => _FlutterreportState();
}

class _FlutterreportState extends State<FeesReport> {
  List<StudentModel> _listStudentModel = [];
  TextEditingController deviceNameController = TextEditingController();
  var _currentItemSelected = "Payment Report";
  String _selectedDrawerIndex = "Payment Report";
  var couponslist = [
    "Payment Report",
    "Due Fee Report",
    "Discount Report",
    "Fine Report",
    "Paid Report",
    "OneTime Paid Report"
  ];
  final dbref = FirebaseDatabase.instance;

  _getReportFragment(String position) {
    switch (position) {
      case "Payment Report":
        return PayementReport(_listStudentModel);
      case "Due Fee Report":
        return DueFeeReport(_listStudentModel);
      case "Discount Report":
        return DiscountReport(_listStudentModel);
      case "Fine Report":
        return FineReport(_listStudentModel);
      case "Paid Report":
        return PaidReport(_listStudentModel);
      case "OneTime Paid Report":
        return OneTimeReport(_listStudentModel);
      default:
        return "Error Ocurred";
    }
  }

  _loadFromDatabase() async {
    final snapshot = await dbref
        .ref()
        .child(
            "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/students")
        .orderByChild("course/${widget.courseId}/courseID")
        .equalTo("${widget.courseId}")
        .once();
    final finesnapshot = await dbref
        .ref()
        .child(
            "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/${widget.courseId}/fees")
        .once();
    List<StudentModel> _list = [];
    Map map = snapshot.snapshot.value as Map;
    map.forEach((key, value) {
      if (value["course"]["${widget.courseId}"]["fees"] != null)
        _list.add(StudentModel.fromJSON(key, value,
            finesnapshot.snapshot.value as Map, "${widget.courseId}"));
    });
    setState(() {
      _listStudentModel = _list;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fee Reports"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: deviceNameController,
              onSubmitted: (val) {},
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {},
                  color: Colors.black,
                  icon: Icon(Icons.search),
                  iconSize: 20.0,
                ),
                contentPadding: EdgeInsets.only(left: 25.0),
                hintText: "Search Here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: DropdownButton<String>(
              items: couponslist.map((String dropDownStringitem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringitem,
                  child: Text(dropDownStringitem),
                );
              }).toList(),
              onChanged: (String? newValueSelected) {
                if (newValueSelected == null) return;
                setState(() {
                  this._currentItemSelected = newValueSelected;
                  _selectedDrawerIndex = newValueSelected;
                });
              },
              isExpanded: false,
              hint: Text('Select Coupon'),
              value: _currentItemSelected,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.66,
            width: MediaQuery.of(context).size.width,
            child: _getReportFragment(_selectedDrawerIndex),
          )
        ],
      ),
    );
  }
}
