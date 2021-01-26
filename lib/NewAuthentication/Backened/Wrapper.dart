import 'package:coach_app/Models/model.dart';
import 'package:coach_app/NewAuthentication/Backened/Wrapper2.dart';
import 'package:coach_app/NewAuthentication/Frontened/LoginFirstPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    if (user == null) {
      return ChangeNotifierProvider(
          create: (context) => Counter(), child: LoginPage());
    } else {
      return Wrapper2();
    }
  }
}
