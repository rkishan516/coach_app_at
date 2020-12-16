import 'package:animator/animator.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:provider/provider.dart';

class SignUpBuild extends StatefulWidget {
  @override
  _SignUpBuildState createState() => _SignUpBuildState();
}

class _SignUpBuildState extends State<SignUpBuild> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  final TextEditingController _fstnameController = TextEditingController();
  final TextEditingController _lstnameController = TextEditingController();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    String result = "";
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 0.0),
      children: [
        Text(
          "SIGNUP",
          style: TextStyle(
              fontSize: 22.0, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20.0,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 40.0,
                      width: 170.0,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "First Name cannot be empty";
                          }
                          return null;
                        },
                        controller: _fstnameController,
                        style:
                            TextStyle(fontSize: 14.0, color: Color(0xFF868A8F)),
                        decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: "FIRST NAME",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 40.0,
                      width: 170.0,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Last name cannot be empty";
                          }
                          return null;
                        },
                        controller: _lstnameController,
                        style:
                            TextStyle(fontSize: 14.0, color: Color(0xFF868A8F)),
                        onChanged: null,
                        decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: "LAST NAME",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 40,
                child: TextFormField(
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
                  controller: _emailController,
                  style: TextStyle(fontSize: 14.0, color: Color(0xFF868A8F)),
                  onChanged: null,
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      hintText: "E-MAIL",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 40,
                child: TextFormField(
                  obscureText: showPassword,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (value.length < 8) {
                      return "Password must be 8 character long";
                    }
                    return null;
                  },
                  controller: _passController,
                  style: TextStyle(fontSize: 14.0, color: Color(0xFF868A8F)),
                  onChanged: null,
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      prefixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: "PASSWORD",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  obscureText: showPassword,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password cannot be empty";
                    }

                    return null;
                  },
                  style: TextStyle(fontSize: 14.0, color: Color(0xFF868A8F)),
                  controller: _confirmpassController,
                  onChanged: null,
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      prefixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: "CONFIRM-PASSWORD",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () async {
                  final formstate = _formKey.currentState;
                  if (formstate.validate()) {
                    if (_passController.text == _confirmpassController.text) {
                      formstate.save();
                      print("Signup");
                      FireBaseAuth.instance.prefs
                          .setString("Email", _emailController.text.trim());
                      FireBaseAuth.instance.prefs
                          .setString("Pass", _passController.text.trim());
                      result = await FireBaseAuth.instance.signUp(
                          _emailController.text.trim(),
                          _passController.text.trim(),
                          _fstnameController.text.trim() +
                              " " +
                              _lstnameController.text.trim(),
                          context);
                      Provider.of<AuthError>(context, listen: false)
                          .errorOccured(result, TypeSelection.typeOfPage);
                    } else {
                      Provider.of<AuthError>(context, listen: false)
                          .errorOccured(
                              "Password unmatched", TypeSelection.typeOfPage);
                    }
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
                  error.resultSignUp,
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF868A8F)),
                );
              }),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      TypeSelection.typeOfPage = "FirstPage";
                      Provider.of<Counter>(context, listen: false)
                          .increment(TypeSelection.typeOfPage);
                    });
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an Account ? ',
                          style:
                              TextStyle(color: Color(0xFF868A8F), fontSize: 16),
                          children: [
                            TextSpan(
                                text: 'Login',
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
