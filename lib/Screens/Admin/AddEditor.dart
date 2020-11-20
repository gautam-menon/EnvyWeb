import 'package:envyweb/Services/ApiFunctions%20-Admin.dart';
import 'package:flutter/material.dart';

class AddEditor extends StatefulWidget {
  @override
  _AddEditorState createState() => _AddEditorState();
}

class _AddEditorState extends State<AddEditor> {
  void _submit(context) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      createEditor(context);
    }
  }

  createEditor(context) async {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
                child: FutureBuilder(
              future: ApiFunctionsAdmin().addEditor(
                name.text,
                email.text,
                tier.text,
                int.parse(phoneNo.text),
              ),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(child: Text("Editor Created!"))
                    : CircularProgressIndicator();
              },
            )));
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
        appBar: AppBar(title: Text("Add Editor")),
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          color: Colors.grey,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  validator: (val) => val.length < 1 ? 'Name too short' : null,
                  controller: name,
                  obscureText: true,
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
                  validator: (val) =>
                      val == 'basic' || val == 'premium' || val == 'pro'
                          ? 'Invalid tier'
                          : null,
                  controller: tier,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Tier",
                      hintStyle:
                          TextStyle(color: Colors.black, fontSize: 12.0)),
                ),
                RaisedButton(
                    child: Text("Create User"), onPressed: () => _submit)
              ],
            ),
          ),
        ));
  }
}
