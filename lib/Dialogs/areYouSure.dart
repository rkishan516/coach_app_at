import 'package:flutter/material.dart';

class AreYouSure extends StatelessWidget {
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
              'Are You Sure ? ',
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
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop('No');
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    color: Colors.deepOrange,
                    onPressed: () {
                      Navigator.of(context).pop('Yes');
                    },
                    child: Text('Yes',style: TextStyle(color: Colors.white),),
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
