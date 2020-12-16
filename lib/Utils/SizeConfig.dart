import 'package:flutter/material.dart';

class SizeConfig {
  MediaQueryData _mediaQueryData;
  double screenWidth;
  double screenHeight;
  double _safeAreaHorizontal;
  double _safeAreaVertical;
  double b;
  double v;

  SizeConfig(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;

    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    b = (screenWidth - _safeAreaHorizontal) / 100;
    v = (screenHeight - _safeAreaVertical) / 100;
  }
}
