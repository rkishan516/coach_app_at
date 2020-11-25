import 'package:flutter/material.dart';
import 'package:coach_app/Utils/Colors.dart';

class NewBannerShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21.0,
      width: 21.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.red,
      ),
      child: Center(
        child: Text(
          "New",
          style: TextStyle(
            color: GuruCoolLightColor.whiteColor,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }
}
