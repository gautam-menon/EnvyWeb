import 'package:envyweb/Screens/Admin/Dashboard.dart';
import 'package:envyweb/Services/Auth.dart';
import 'package:envyweb/Services/Widgets/DrawerItems.dart';
import 'package:flutter/material.dart';

import '../HomePage.dart';

class EditorPage extends StatefulWidget {
  final name;

  const EditorPage({Key key, this.name}) : super(key: key);
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Customize("Dashboard", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminPage()));
                }),
                Customize("Pending Orders", () {}),
                Customize("Completed Orders", () {}),
                Customize("Profile", () {}),
                Customize("Log out", () async {
                  await AuthService().logOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()),
                      (Route<dynamic> route) => false);
                }),
              ],
            ),
          ),
        ),
        body: Container(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Editor, " + widget.name.toString(),
                            style: TextStyle(
                                fontSize: 35,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Incoming Orders",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]))))));
  }
}
