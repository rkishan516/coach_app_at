import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:firebase_database/firebase_database.dart';
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
  List<String> _currentDurationSelected = List.filled(25, '');
  late List<TextEditingController> _listEditingControllerDD;
  late List<TextEditingController> _listEditingControllerYYYY;
  late List<TextEditingController> _listEditingControllerMoney;
  late Map map;
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
                      .ref()
                      .child(
                          "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/${widget.courseId}/fees")
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
                  color: Color(0xffF36C24),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${index + 1} Installment',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
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
                                color: Colors.white,
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
                                style: TextStyle(color: Color(0xffF36C24)),
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
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    contentPadding: EdgeInsets.only(top: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Enter value"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              '₹',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
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
                                color: Colors.white,
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
                              style: TextStyle(color: Color(0xffF36C24)),
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
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  contentPadding: EdgeInsets.only(top: 0),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle:
                                      TextStyle(color: Color(0xffF36C24)),
                                  hintText: "DD"),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButton<String>(
                              iconEnabledColor: Colors.white,
                              dropdownColor: Color(0xffF36C24),
                              items: durationperiod
                                  .map((String dropDownStringitem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringitem,
                                  child: Text(
                                    dropDownStringitem,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValueSelected) {
                                if (newValueSelected == null) return;
                                setState(() {
                                  _currentDurationSelected[index] =
                                      newValueSelected;
                                });
                              },
                              isExpanded: true,
                              hint: Text(
                                'MM',
                                style: TextStyle(color: Colors.white),
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
                              style: TextStyle(color: Color(0xffF36C24)),
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
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                contentPadding: EdgeInsets.only(top: 0),
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: TextStyle(color: Color(0xffF36C24)),
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
          .ref()
          .child(
              "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/${widget.courseId}/fees")
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
        .ref()
        .child(
            "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/${widget.courseId}/fees")
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
            color: Color(0xffF36C24)),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          "Confirm",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _loadFromDatabase() async {
    dbRef
        .ref()
        .child(
            "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/${widget.courseId}/fees")
        .child("MaxInstallment")
        .once()
        .then((snapshot) {
      map = snapshot.snapshot.value as Map;
      setState(() {
        noOfTextFields = int.parse(map["MaxAllowedInstallment"]);
        _maxInstallText.text = noOfTextFields.toString();
        _listEditingControllerDD = new List<TextEditingController>.filled(
            noOfTextFields, TextEditingController());
        _listEditingControllerYYYY = new List<TextEditingController>.filled(
            noOfTextFields, TextEditingController());
        _listEditingControllerMoney = List.filled(
          noOfTextFields,
          TextEditingController(),
        );
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
                          new List<TextEditingController>.filled(
                              noOfTextFields, TextEditingController());
                      _listEditingControllerYYYY =
                          new List<TextEditingController>.filled(
                              noOfTextFields, TextEditingController());
                      _listEditingControllerMoney = new List.filled(
                          noOfTextFields, TextEditingController());
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
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF36C24),
                    enabled: !widget.toggleValue,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
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
              color: Colors.white,
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
