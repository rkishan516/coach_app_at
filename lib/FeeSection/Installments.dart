import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

class Installments extends StatefulWidget {
  final String totalFees;
  final bool toggleValue;
  final String courseId;
  Installments(this.totalFees, this.toggleValue, this.courseId);
  @override
  _InstallmentsState createState() => _InstallmentsState();
}

class _InstallmentsState extends State<Installments> {
  int noOfTextFields = 0;
  List<String> _currentDurationSelected = List(25);
  List<TextEditingController> _listEditingControllerDD;
  List<TextEditingController> _listEditingControllerYYYY;
  List<TextEditingController> _listEditingControllerMoney;
  Map map;
  bool editValue = false;
  final dbRef = FirebaseDatabase.instance;
  final TextEditingController _maxInstallText = TextEditingController();

  var durationperiod = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];

  Widget _createTextFields(int value) {
    if (value != 0) {
      if (editValue) {
        for (int i = 0; i < noOfTextFields; i++) {
          String pass = (i + 1).toString() + "Installment";
          _listEditingControllerMoney[i].text =
              map["Installments"][pass]["Amount"];
          _listEditingControllerDD[i].text =
              map["Installments"][pass]["Duration"].toString().split(" ")[0];
          _currentDurationSelected[i] =
              map["Installments"][pass]["Duration"].toString().split(" ")[1];
          _listEditingControllerYYYY[i].text =
              map["Installments"][pass]["Duration"].toString().split(" ")[2];
          editValue = false;
        }
      }

      return ListView.builder(
          itemCount: value,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () async {
                String res = await showDialog(
                    context: context, builder: (context) => AreYouSure());
                if (res != 'Yes') {
                  return;
                }
                setState(() {
                  dbRef
                      .reference()
                      .child(
                          "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees")
                      .child(
                          "MaxInstallment/Installments/${(index + 1).toString() + "Installment"}")
                      .remove();
                  noOfTextFields -= 1;
                });
              },
              child: Card(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: GuruCoolLightColor.primaryColor,
                ),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${index + 1} Installment',
                          style:
                              TextStyle(color: GuruCoolLightColor.whiteColor),
                        ),
                      ),
                    ),
                    Divider(
                      color: GuruCoolLightColor.whiteColor,
                      height: 2,
                      thickness: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Amount',
                              style: TextStyle(
                                color: GuruCoolLightColor.whiteColor,
                              ),
                            ),
                          )),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  //TODO
                                },
                                controller: _listEditingControllerMoney[index],
                                style: TextStyle(color: GuruCoolLightColor.primaryColor),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        borderSide: BorderSide(
                                            color:
                                                GuruCoolLightColor.whiteColor)),
                                    contentPadding: EdgeInsets.only(top: 0),
                                    filled: true,
                                    fillColor: GuruCoolLightColor.whiteColor,
                                    hintText: "Enter value"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              '₹',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: GuruCoolLightColor.whiteColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Last Submission Date',
                              style: TextStyle(
                                color: GuruCoolLightColor.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              onChanged: (value) {
                                //TODO
                              },
                              controller: _listEditingControllerDD[index],
                              style: TextStyle(color: GuruCoolLightColor.primaryColor),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      borderSide: BorderSide(
                                          color:
                                              GuruCoolLightColor.whiteColor)),
                                  contentPadding: EdgeInsets.only(top: 0),
                                  filled: true,
                                  fillColor: GuruCoolLightColor.whiteColor,
                                  hintStyle:
                                      TextStyle(color: GuruCoolLightColor.primaryColor),
                                  hintText: "DD"),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButton<String>(
                              iconEnabledColor: GuruCoolLightColor.whiteColor,
                              dropdownColor: GuruCoolLightColor.primaryColor,
                              items: durationperiod
                                  .map((String dropDownStringitem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringitem,
                                  child: Text(
                                    dropDownStringitem,
                                    style: TextStyle(
                                        color: GuruCoolLightColor.whiteColor),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  _currentDurationSelected[index] =
                                      newValueSelected;
                                });
                              },
                              isExpanded: true,
                              hint: Text(
                                'MM',
                                style: TextStyle(
                                    color: GuruCoolLightColor.whiteColor),
                              ),
                              value: _currentDurationSelected[index],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              onChanged: (value) {
                                //TODO
                              },
                              controller: _listEditingControllerYYYY[index],
                              style: TextStyle(color: GuruCoolLightColor.primaryColor),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    borderSide: BorderSide(
                                        color: GuruCoolLightColor.whiteColor)),
                                contentPadding: EdgeInsets.only(top: 0),
                                filled: true,
                                fillColor: GuruCoolLightColor.whiteColor,
                                hintStyle: TextStyle(color: GuruCoolLightColor.primaryColor),
                                hintText: "YYYY",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4.0,
                        )
                      ],
                    ),
                  ],
                ),
              )),
            );
          });
    } else
      return SizedBox(
        height: 4.0,
      );
  }

  _saveintodatabase() {
    for (int i = 0; i < noOfTextFields; i++) {
      dbRef
          .reference()
          .child(
              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees")
          .child("MaxInstallment/Installments")
          .update({
        ((i + 1)).toString() + "Installment": {
          "Amount": _listEditingControllerMoney[i].text,
          "Duration": _listEditingControllerDD[i].text +
              " " +
              _currentDurationSelected[i] +
              " " +
              _listEditingControllerYYYY[i].text
        }
      });
    }
    dbRef
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees")
        .child("MaxInstallment")
        .update({
      "IsMaxAllowed": true,
      "MaxAllowedInstallment": _maxInstallText.text
    });
    Navigator.of(context).pop("confirm");
  }

  Widget _saveButton() {
    return GestureDetector(
      onTap: () async {
        String val = await showDialog(
          context: context,
          builder: (context) => AreYouSure(
            text: 'Once No of Installments is saved can not be altered',
          ),
        );
        if (val != 'Yes') {
          return;
        }
        _saveintodatabase();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: GuruCoolLightColor.primaryColor),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          "Confirm",
          style: TextStyle(color: GuruCoolLightColor.whiteColor),
        ),
      ),
    );
  }

  _loadFromDatabase() async {
    dbRef
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees")
        .child("MaxInstallment")
        .once()
        .then((snapshot) {
      map = snapshot.value;
      setState(() {
        noOfTextFields = int.parse(map["MaxAllowedInstallment"]);
        _maxInstallText.text = noOfTextFields.toString();
        _listEditingControllerDD =
            new List<TextEditingController>(noOfTextFields);
        _listEditingControllerYYYY =
            new List<TextEditingController>(noOfTextFields);
        _listEditingControllerMoney = new List(noOfTextFields);
        for (int i = 0; i < noOfTextFields; i++) {
          _listEditingControllerMoney[i] = TextEditingController(
              text: !editValue
                  ? (double.parse(
                          (double.parse(widget.totalFees) / noOfTextFields)
                              .toStringAsFixed(2))
                      .toString())
                  : "");
          _listEditingControllerDD[i] = TextEditingController();
          _listEditingControllerYYYY[i] = TextEditingController();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    editValue = widget.toggleValue;
    if (editValue) _loadFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        controller: ScrollController(),
        padding: EdgeInsets.all(12.0),
        children: [
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    'Total Installments',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                  )),
              Expanded(
                flex: 2,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      noOfTextFields = int.parse(value != "" ? value : "0");
                      _listEditingControllerDD =
                          new List<TextEditingController>(noOfTextFields);
                      _listEditingControllerYYYY =
                          new List<TextEditingController>(noOfTextFields);
                      _listEditingControllerMoney = new List(noOfTextFields);
                      for (int i = 0; i < noOfTextFields; i++) {
                        _listEditingControllerMoney[i] = TextEditingController(
                            text: !editValue
                                ? (double.parse(
                                        (double.parse(widget.totalFees) /
                                                noOfTextFields)
                                            .toStringAsFixed(2))
                                    .toString())
                                : "");
                        _listEditingControllerDD[i] = TextEditingController();
                        _listEditingControllerYYYY[i] = TextEditingController();
                      }
                    });
                  },
                  controller: _maxInstallText,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: GuruCoolLightColor.whiteColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: GuruCoolLightColor.primaryColor,
                    enabled: !widget.toggleValue,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: GuruCoolLightColor.whiteColor,
                      ),
                    ),
                    hintStyle: TextStyle(color: GuruCoolLightColor.whiteColor),
                    hintText: "Enter No. of Installments",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
              color: GuruCoolLightColor.whiteColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.66,
              child: _createTextFields(noOfTextFields)),
          SizedBox(
            height: 8.0,
          ),
          _saveButton()
        ],
      ),
    );
  }
}
