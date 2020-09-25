import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final String studentUid;
  final String courseId;
  ToggleButton({this.studentUid, this.courseId});
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool toggleValue = false;
  bool doOpen = true;
  List<String> couponslist = ["none"];
  var _currentItemSelected = "none";
  final dbRef = FirebaseDatabase.instance;
  Future showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Coupon'),
          content: DropdownButton<String>(
            items: couponslist.map((String dropDownStringitem) {
              return DropdownMenuItem<String>(
                value: dropDownStringitem,
                child: Text("Discount coupon : " +
                    (dropDownStringitem == 'none' ? "0" : dropDownStringitem) +
                    "%"),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                this._currentItemSelected = newValueSelected;
                if (_currentItemSelected == "none") {
                  toggleValue = false;
                  doOpen = true;
                } else {
                  toggleValue = true;
                  doOpen = true;
                }
              });
              Navigator.of(context).pop("Selected");
            },
            isExpanded: false,
            hint: Text('Select Coupon'),
            value: _currentItemSelected,
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop("cancel");
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    dbRef
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coupons")
        .once()
        .then((snapshot) {
      snapshot.value?.forEach((key, value) {
        couponslist.add(snapshot.value[key]["discount"]);
      });
    });
    dbRef
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}")
        .child(
            "students/${widget.studentUid}/course/${widget.courseId}/discount")
        .once()
        .then((snapshot) {
      setState(() {
        if (snapshot.value.toString() != "none" && snapshot.value != null) {
          toggleValue = true;
          doOpen = false;
          _currentItemSelected = snapshot.value.toString();
        } else {
          _currentItemSelected = "none";
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Attach Coupon : ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
          flex: 2,
          child: Switch(
            onChanged: toggleButton,
            value: toggleValue,
            inactiveTrackColor: Colors.white,
            activeColor: Colors.white,
          ),
        ),
        // Expanded(
        //   flex: 2,
        //   child: GestureDetector(
        //     onLongPress: () {
        //       if (toggleValue)
        //         showErrorDialog(context).then((value) {
        //           if (value == "Selected") {
        //             if (_currentItemSelected != "none")
        //               dbRef
        //                   .reference()
        //                   .child(
        //                       "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}")
        //                   .child(
        //                       "students/${widget.studentUid}/course/${widget.courseId}")
        //                   .update({"discount": _currentItemSelected});
        //             else {
        //               dbRef
        //                   .reference()
        //                   .child(
        //                       "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}")
        //                   .child(
        //                       "students/${widget.studentUid}/course/${widget.courseId}/discount")
        //                   .remove();
        //             }
        //           }
        //         });
        //     },
        //     child: AnimatedContainer(
        //       duration: Duration(milliseconds: 1000),
        //       height: 40.0,
        //       width: 100.0,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20.0),
        //         color: toggleValue
        //             ? Colors.greenAccent[100]
        //             : Colors.redAccent[100].withOpacity(0.5),
        //       ),
        //       child: Stack(
        //         children: [
        //           AnimatedPositioned(
        //             duration: Duration(milliseconds: 1000),
        //             curve: Curves.easeIn,
        //             left: toggleValue ? 60.0 : 0.0,
        //             right: toggleValue ? 0.0 : 60.0,
        //             child: InkWell(
        //               onTap: toggleButton,
        //               child: AnimatedSwitcher(
        //                 duration: Duration(microseconds: 1000),
        //                 transitionBuilder:
        //                     (Widget child, Animation<double> animation) {
        //                   return RotationTransition(
        //                     child: child,
        //                     turns: animation,
        //                   );
        //                 },
        //                 child: toggleValue
        //                     ? Icon(
        //                         Icons.check_circle,
        //                         color: Colors.green,
        //                         size: 35.0,
        //                         key: UniqueKey(),
        //                       )
        //                     : Icon(
        //                         Icons.remove_circle_outline,
        //                         color: Colors.red,
        //                         size: 35.0,
        //                         key: UniqueKey(),
        //                       ),
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  toggleButton(val) {
    setState(() {
      toggleValue = !toggleValue;
      if (toggleValue && doOpen) {
        showErrorDialog(context).then((value) {
          if (value == "Selected") {
            dbRef
                .reference()
                .child(
                    "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}")
                .child(
                    "students/${widget.studentUid}/course/${widget.courseId}")
                .update({"discount": _currentItemSelected});
          } else {
            if (_currentItemSelected == "none")
              setState(() {
                toggleValue = false;
              });
          }
        });
      } else {
        dbRef
            .reference()
            .child(
                "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}")
            .child(
                "students/${widget.studentUid}/course/${widget.courseId}/discount")
            .remove();
        _currentItemSelected = "none";
      }
      doOpen = true;
    });
  }
}
