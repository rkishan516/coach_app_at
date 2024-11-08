import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WaitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xffF36C24)])),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'You will get admission in your digital institute as soon as administrator permits you',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (AppwriteAuth.instance.instituteid != null &&
                          AppwriteAuth.instance.branchid != null)
                        FirebaseDatabase.instance
                            .ref()
                            .child(
                                'instiute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/students/${AppwriteAuth.instance.user!.$id}/status')
                            .set("New Student");
                      AppwriteAuth.instance.signoutWithGoogle();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()),
                          (route) => false);
                    },
                    child: Text(
                      'Withdraw Request',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
