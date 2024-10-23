import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AreYouSure extends StatelessWidget {
  final String? text;
  AreYouSure({this.text});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: 30.0 + 16.0,
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
              text ?? 'Are You Sure ?'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop('No');
                    },
                    child: Text('No'.tr()),
                  ),
                  MaterialButton(
                    color: Color(0xffF36C24),
                    onPressed: () {
                      Navigator.of(context).pop('Yes');
                    },
                    child: Text(
                      'Yes'.tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
