import 'package:flutter/material.dart';

class NoGlowScroolBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;
}
