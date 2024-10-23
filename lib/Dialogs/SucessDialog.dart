import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String success;
  SuccessDialog({required this.success});
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
              top: 16.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 16.0),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Successfully Done!'.tr(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  success,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
