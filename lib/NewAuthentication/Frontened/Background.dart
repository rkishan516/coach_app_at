import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final List<Widget> children;
  LoginBackground({@required this.children});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Animator<Offset>(
              tween: Tween<Offset>(
                  begin: Offset(-1, -0.4), end: Offset(-0.6, -0.3)),
              cycles: 1,
              duration: Duration(seconds: 3),
              builder: (context, animatorState, child) => FractionalTranslation(
                translation: animatorState.value,
                child: Container(
                  height: 300.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      color: Color(0xFFE6E7E8)),
                ),
              ),
            ),
            ...children,
            Animator<Offset>(
              tween: Tween<Offset>(begin: Offset(1, 1), end: Offset(0.85, 1)),
              cycles: 1,
              duration: Duration(seconds: 3),
              builder: (context, animatorState, child) => FractionalTranslation(
                translation: animatorState.value,
                child: Container(
                  height: 250.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150.0),
                    color: Color(0xffffe6cc).withOpacity(0.4).withGreen(
                          220,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
