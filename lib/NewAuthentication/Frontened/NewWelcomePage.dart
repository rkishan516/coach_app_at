// import 'package:animator/animator.dart';
// import 'package:coach_app/Models/model.dart';
// import 'package:coach_app/NewAuthentication/Frontened/Background.dart';
// import 'package:coach_app/NewAuthentication/Frontened/LoginFirstPage.dart';
// import 'package:coach_app/Utils/NoGlowScroolBehaviour.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'FirstPageBuild.dart';

// class NewWelcomePage extends StatefulWidget {
//   @override
//   _NewWelcomePageState createState() => _NewWelcomePageState();
// }

// class _NewWelcomePageState extends State<NewWelcomePage> {
//   DateTime currentBackPressTime;
//   @override
//   void initState() {
//     TypeSelection.typeOfPage = "FirstPage";
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<Counter>(context, listen: false)
//           .increment(TypeSelection.typeOfPage);
//     });
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     // return LoginPage();
//     return WillPopScope(
//       onWillPop: () async {
//         if (TypeSelection.typeOfPage == "FirstPage") {
//           DateTime now = DateTime.now();
//           if (currentBackPressTime == null ||
//               now.difference(currentBackPressTime) > Duration(seconds: 2)) {
//             currentBackPressTime = now;
//             return Future.value(false);
//           }
//           return Future.value(true);
//         }
//         setState(() {
//           TypeSelection.typeOfPage = "FirstPage";
//           Provider.of<Counter>(context, listen: false)
//               .increment(TypeSelection.typeOfPage);
//         });
//         return false;
//       },
//       child: LoginBackground(
//         children: [
//           Consumer<Counter>(builder: (context, counter, child) {
//             return Animator<double>(
//               cycles: 1,
//               tween: Tween<double>(begin: 0, end: 1),
//               duration: Duration(seconds: 2),
//               builder: (context, animatorState, child) => Animator<Offset>(
//                   animatorKey: counter.logoAnimatorKey,
//                   cycles: 1,
//                   tween: Tween<Offset>(
//                     begin: Offset(0.25, 0.4),
//                     end: Offset(0.25, 0.4),
//                   ),
//                   builder: (context, animator, child) {
//                     return FractionalTranslation(
//                       translation: animator.value,
//                       child: Opacity(
//                         opacity: animatorState.value,
//                         child: Container(
//                           height: counter.size.height,
//                           width: counter.size.width,
//                           child: Image(
//                             key: UniqueKey(),
//                             image: AssetImage('assets/splash.png'),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             );
//           }),
//           Consumer<Counter>(builder: (context, counter, _) {
//             return Animator<Offset>(
//               animatorKey: counter.animatorKey,
//               tween: Tween<Offset>(begin: Offset(0, 3), end: Offset(0, 2.5)),
//               duration: Duration(milliseconds: 1000),
//               cycles: 1,
//               builder: (context, animatorState, child) {
//                 return ScrollConfiguration(
//                   behavior: NoGlowScroolBehaviour(),
//                   child: FractionalTranslation(
//                     translation: animatorState.value,
//                     child: FirstPageBuild(),
//                   ),
//                 );
//               },
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }
