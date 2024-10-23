import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Alert {
  static Alert instance = Alert._();
  Alert._();

  Future alert(BuildContext context, String alertString) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
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
                    top: 66.0 + 16.0,
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
                      Text(
                        'Oh, No!'.tr(),
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        alertString,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'.tr()),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16.0,
                  right: 16.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 66.0,
                    child: Icon(
                      Icons.cancel,
                      size: 66.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
