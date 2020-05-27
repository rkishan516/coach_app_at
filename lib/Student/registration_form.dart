import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameTextEditingController,
      addressTextEditingController,
      phoneTextEditingController;
  String status = 'New Student';
  DateTime dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Name'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: nameTextEditingController,
                  decoration: InputDecoration(
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
                Text(
                  'Address'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: addressTextEditingController,
                  decoration: InputDecoration(
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
                Text(
                  'Phone No'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                Text(
                  'Date of Birth'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now(),
                  onDateChanged: (v) {
                    dob = v;
                  },
                  initialCalendarMode: DatePickerMode.year,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Status'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton(
                    items: ['Existing Student', 'New Student']
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e.tr()),
                            value: e,
                          ),
                        )
                        .toList(),
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
