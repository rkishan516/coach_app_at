import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No Internet Connection').tr(),
      ),
    );
  }
}
