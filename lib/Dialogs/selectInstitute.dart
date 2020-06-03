import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectInstituteCourse extends StatefulWidget {
  final DatabaseReference databaseReference;
  SelectInstituteCourse({@required this.databaseReference});
  @override
  _SelectInstituteState createState() => _SelectInstituteState();
}

class _SelectInstituteState extends State<SelectInstituteCourse> {
  String selectedCourseID;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              top: 20.0 + 16.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Select Course'.tr(),
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                StreamBuilder<Event>(
                  stream:
                      widget.databaseReference.child('/coursesList').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, String> course = Map<String, String>();
                      snapshot.data.snapshot.value?.forEach((k, v) {
                        course[k] = v;
                      });
                      return DropdownButton(
                          value: selectedCourseID,
                          hint: Text('Select Course'.tr()),
                          items: course
                              .map(
                                (k, e) => MapEntry(
                                  k,
                                  DropdownMenuItem(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: Text(
                                        e,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    value: k,
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCourseID = value;
                            });
                          });
                    } else {
                      return Container();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(selectedCourseID);
                    },
                    child: Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
