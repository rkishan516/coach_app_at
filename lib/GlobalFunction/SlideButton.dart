import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SlideButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Function onTap;
  final Icon icon;
  SlideButton(
      {@required this.text,
      @required this.onTap,
      @required this.width,
      @required this.height,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            color: Colors.white),
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                child: icon == null ? Icon(Icons.add) : icon,
                backgroundColor: Color(0xffFF6C24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Center(
                child: Text(text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideButtonR extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Function onTap;
  SlideButtonR(
      {@required this.text,
      @required this.onTap,
      @required this.width,
      @required this.height});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            color: Colors.white),
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Center(
                child: Text(text),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                child: Icon(Icons.add),
                backgroundColor: Color(0xffFF6C24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideButtonCovered extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Function onTap;
  final Icon icon;
  SlideButtonCovered(
      {@required this.text,
      @required this.onTap,
      @required this.width,
      @required this.height,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            color: Color(0xffFF6C24)),
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                child: icon == null ? Icon(Icons.add) : icon,
                backgroundColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Center(
                child: Text(
                  text.tr(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
