import 'package:envyweb/Screens/Admin/Dashboard.dart';

import 'package:envyweb/Services/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() async {
    setState(() {
      _isLoading = true;
    });
    var result = await AuthService()
        .logIn(emailController.text, passwordController.text);
    if (result == null) {
      setState(() {
        _isLoading = false;
      });
      showAlertDialog(context, "Incorrect email or password");
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  AdminPage(name: result.user.displayName)),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 18,
              ),
            )
          : Container(
              padding: EdgeInsets.only(bottom: 1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0),
                  ]),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Text("Welcome",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: "Poppins-Bold",
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [
                                  const Color(0xff17053A),
                                  Colors.purple
                                ],
                              )),
                              //decoration: BoxDecoration(border: Border.all()),
                              height: 400,
                              width: 400,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 16.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Email",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Medium",
                                          )),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (val) => !val.contains('@')
                                            ? 'Please enter a valid email address.'
                                            : null,
                                        controller: emailController,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0)),
                                      ),
                                      SizedBox(),
                                      Text("Password",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Medium",
                                          )),
                                      TextFormField(
                                        validator: (val) => val.length < 8
                                            ? 'Password too short (Should be at least 8 characters)'
                                            : null,
                                        controller: passwordController,
                                        obscureText: true,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0)),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0xFF6078ea)
                                                        .withOpacity(.3),
                                                    blurRadius: 8.0)
                                              ]),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: _submit,
                                              child: Center(
                                                child: Text("LOG IN",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF650572),
                                                        fontFamily:
                                                            "Poppins-Bold",
                                                        fontSize: 18,
                                                        letterSpacing: 1.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             ForgotPass()));
                                              },
                                              child: Text(
                                                "Forgot Password?",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins-Medium",
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    // color: themeColor,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => Signup()));
                                  },
                                  child: Text("Create one",
                                      style: TextStyle(
                                        color: Color(0xFF5d74e3),
                                        fontFamily: "Poppins-Bold",
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  showAlertDialog(BuildContext context, String text) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error logging in"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
