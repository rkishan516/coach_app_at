// import 'package:coach_app/Chat/all_users_screen.dart';
// import 'package:coach_app/Chat/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   MyAppState createState() {
//     return new MyAppState();
//   }
// }

// class MyAppState extends State<MyApp> {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   GoogleSignIn googleSignIn = GoogleSignIn();
//   bool isLoggedIn = false;

//   void isSignedIn() async {
//     if (await googleSignIn.isSignedIn()) {
//       setState(() {
//         isLoggedIn = true;
//       });
//     } else {
//       setState(() {
//         isLoggedIn = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     isSignedIn();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Chat App",
//       theme: ThemeData(primarySwatch: Colors.orange),
//       routes: <String, WidgetBuilder>{
//         '/chatscreen': (BuildContext context) => new AllUsersScreen(),
//       },
//       home: HomePage(),
//     );
//   }
// }
