import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:provider/provider.dart';

class LoginPageBuild extends StatefulWidget {
  @override
  _LoginPageBuildState createState() => _LoginPageBuildState();
}

class _LoginPageBuildState extends State<LoginPageBuild> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return ListView(
      padding: EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 0.0),
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "LOGIN",
          style: TextStyle(
              fontSize: 22.0,
              color: Color(0xFF868A8F),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20.0,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Email cannot be empty";
                  }
                  if (!RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                      .hasMatch(value)) {
                    return 'Please enter a valid email Address';
                  }
                  return null;
                },
                style: TextStyle(fontSize: 14.0, color: Color(0xFF868A8F)),
                onChanged: null,
                decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    hintText: "EMAIL",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _passController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
                style: TextStyle(fontSize: 14.0, color: Color(0xFF868A8F)),
                onChanged: null,
                decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    hintText: "PASSWORD",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              SizedBox(
                height: 35.0,
              ),
              InkWell(
                onTap: () async {
                  final formstate = _formKey.currentState;
                  if (formstate.validate()) {
                    formstate.save();
                    String result = await FireBaseAuth.instance.signIn(
                        _emailController.text.trim(),
                        _passController.text.trim(),
                        context);
                    Provider.of<AuthError>(context, listen: false)
                        .errorOccured(result, TypeSelection.typeOfPage);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  height: _height * 0.05,
                  width: _width,
                  decoration: BoxDecoration(
                    color: Color(0xFFEF7334),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      "PROCEED",
                      style: TextStyle(color: GuruCoolLightColor.whiteColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Consumer<AuthError>(builder: (context, error, child) {
                return Text(
                  error.resultLogin,
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF868A8F)),
                );
              }),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      TypeSelection.typeOfPage = "SignUpPage";
                      Provider.of<Counter>(context, listen: false)
                          .increment(TypeSelection.typeOfPage);
                    });
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an Account ? ",
                          style:
                              TextStyle(color: Color(0xFF868A8F), fontSize: 16),
                          children: [
                            TextSpan(
                                text: 'Signup',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 16))
                          ]),
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
