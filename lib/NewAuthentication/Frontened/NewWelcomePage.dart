import 'package:animator/animator.dart';
import 'package:coach_app/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FirstPageBuild.dart';
import 'LoginPageBuild.dart';
import 'SignUpBuild.dart';

class NewWelcomePage extends StatefulWidget {
  @override
  _NewWelcomePageState createState() => _NewWelcomePageState();
}

class _NewWelcomePageState extends State<NewWelcomePage> {
  final animatorkey = AnimatorKey<Offset>();
  final logoanimatorKey = AnimatorKey<Offset>();
  final circleanimatorKey = AnimatorKey<Offset>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animatorkey.triggerAnimation();
      circleanimatorKey.triggerAnimation();
    });

    TypeSelection.typeOfPage = "FirstPage";
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          TypeSelection.typeOfPage = "FirstPage";
          Provider.of<Counter>(context, listen: false)
              .increment(TypeSelection.typeOfPage);
          animatorkey.refreshAnimation(
              tween: Tween<Offset>(begin: Offset(0, 0.1), end: Offset(0, 0.2)),
              curve: Curves.fastOutSlowIn);
          circleanimatorKey.refreshAnimation(
              tween: Tween<Offset>(
                  begin: Offset(-0.6, -0.4), end: Offset(-0.6, -0.3)),
              curve: Curves.easeInSine,
              duration: Duration(milliseconds: 500));
          logoanimatorKey.refreshAnimation(
              tween:
                  Tween<Offset>(begin: Offset(0, -0.8), end: Offset(0, -0.7)),
              curve: Curves.easeInSine,
              duration: Duration(milliseconds: 500));
        });
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Animator<Offset>(
              tween:
                  Tween<Offset>(begin: Offset(1, 1.2), end: Offset(0.7, 1.2)),
              cycles: 1,
              builder: (context, animatorState, child) => FractionalTranslation(
                translation: animatorState.value,
                child: Container(
                  height: 300.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      color: Color(0xffffe6cc).withOpacity(0.4).withGreen(220)),
                ),
              ),
            ),
            Column(
              children: [
                Consumer<Counter>(
                  builder: (context, counter, child) => Expanded(
                    flex: counter.flexofCircle,
                    child: Animator<Offset>(
                      animatorKey: circleanimatorKey,
                      tween: Tween<Offset>(
                          begin: Offset(-1, -0.4), end: Offset(-0.6, -0.3)),
                      cycles: 1,
                      builder: (context, animatorState, child) =>
                          FractionalTranslation(
                        translation: animatorState.value,
                        child: Container(
                          height: 400.0,
                          width: 400.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(180.0),
                              color: Color(0xFFE6E7E8)),
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<Counter>(
                  builder: (context, counter, child) => Expanded(
                    flex: counter.flexofLogo,
                    child: Animator(
                      animatorKey: logoanimatorKey,
                      cycles: 1,
                      tween: Tween<Offset>(
                          begin: Offset(0, -0.7), end: Offset(0, -0.9)),
                      duration: Duration(seconds: 1),
                      builder: (context, animatorState, child) =>
                          FractionalTranslation(
                              translation: animatorState.value,
                              child: Container(
                                height: 250.0,
                                width: 250.0,
                                child: Image(
                                    key: UniqueKey(),
                                    width: 250.0,
                                    height: 250.0,
                                    image: AssetImage('assets/splash.png')),
                              )),
                    ),
                  ),
                ),
                Consumer<Counter>(
                  builder: (context, counter, child) => Expanded(
                    flex: counter.flexofFields,
                    child: Animator<Offset>(
                      animatorKey: animatorkey,
                      tween: Tween<Offset>(
                          begin: Offset(0, 1), end: Offset(0, 0.2)),
                      cycles: 1,
                      builder: (context, animatorState, child) {
                        return FractionalTranslation(
                            translation: animatorState.value,
                            child: TypeSelection.typeOfPage == "FirstPage"
                                ? FirstPageBuild(
                                    animatorKey: animatorkey,
                                    logoanimatorKey: logoanimatorKey,
                                    circleanimatorKey: circleanimatorKey)
                                : TypeSelection.typeOfPage == "LoginPage"
                                    ? ChangeNotifierProvider(
                                        create: (context) => AuthError(),
                                        child: LoginPageBuild(
                                            animatorKey: animatorkey,
                                            logoanimatorKey: logoanimatorKey,
                                            circleanimatorKey:
                                                circleanimatorKey),
                                      )
                                    : ChangeNotifierProvider(
                                        create: (context) => AuthError(),
                                        child: SignUpBuild(
                                            animatorKey: animatorkey,
                                            logoanimatorKey: logoanimatorKey,
                                            circleanimatorKey:
                                                circleanimatorKey),
                                      ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
