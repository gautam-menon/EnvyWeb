import 'package:envyweb/Services/ApiFunctions%20-Admin.dart';
import 'package:flutter/material.dart';

class AddEditor extends StatefulWidget {
  @override
  _AddEditorState createState() => _AddEditorState();
}

class _AddEditorState extends State<AddEditor> {
  bool visible = false;
  void _submit(context) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        visible = true;
      });
      createEditor(context);
    }
  }

  createEditor(context) async {
    var response = await ApiFunctionsAdmin().addEditor(
      name.text,
      email.text,
      password.text,
      tier.text,
      phoneNo.text,
    );
    print(response);
    bool condition = response['status'];
    if (condition) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
              child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.done,
                          size: 70,
                          color: Colors.green,
                        ),
                        Text("Account Created Successfully!"),
                        RaisedButton(
                          child: Text("Okay"),
                          onPressed: () {
                            setState(() {
                              visible = false;
                            });
                            Navigator.of(context).pop();
                          },
                        )
                      ]))));
    } else {
      showDialog(
          context: context,
          builder: (context) => Dialog(
              child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.error,
                          size: 70,
                          color: Colors.red,
                        ),
                        Text(response['req'] ?? "Account could not be created"),
                        RaisedButton(
                          child: Text("Okay"),
                          onPressed: () {
                            setState(() {
                              visible = false;
                            });
                            Navigator.of(context).pop();
                          },
                        )
                      ]))));
    }
  }

  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController tier = new TextEditingController();
  final TextEditingController phoneNo = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Editor"),
          centerTitle: true,
        ),
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          color: Colors.grey,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: visible,
                    child: Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.1,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Creating account...",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            CircularProgressIndicator()
                          ],
                        )),
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.length < 1 ? 'Name too short' : null,
                    controller: name,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 12.0)),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) => !val.contains('@')
                        ? 'Please enter a valid email address.'
                        : null,
                    controller: email,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 12.0)),
                  ),
                  TextFormField(
                    validator: (val) => val.length < 8
                        ? 'Password too short (Should be at least 8 characters)'
                        : null,
                    controller: password,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 12.0)),
                  ),
                  TextFormField(
                    validator: (val) => val.length < 8
                        ? 'Number too short (Should be at least 9 characters)'
                        : null,
                    controller: phoneNo,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 12.0)),
                  ),
                  TextFormField(
                    validator: (val) => val == 'basic' ||val=='premium'||val=='pro' ?  null:'Invalid tier',
                    controller: tier,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "Tier",
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 12.0)),
                  ),
                  RaisedButton(
                      child: Text("Create User"),
                      onPressed: () => _submit(context))
                ],
              ),
            ),
          ),
        ));
  }
}
