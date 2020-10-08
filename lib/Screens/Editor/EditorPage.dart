import 'package:envyweb/Screens/Editor/OrderPage.dart';
import 'package:envyweb/Services/Auth.dart';
import 'package:envyweb/Services/Widgets/DrawerItems.dart';
import 'package:flutter/cupertino.dart';
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
                      MaterialPageRoute(builder: (context) => EditorPage()));
                }),
                Customize("Profile", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditorPage()));
                }),
                Customize("Completed Orders", () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderPage()));
                }),
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
                      ),
                      EditorOrderFunction(
                          orderID: "4803", date: 3424, deadline: 4995)
                    ]))))));
  }
}

class EditorOrderFunction extends StatelessWidget {
  final String orderID;

  final int date;
  final int deadline;

  const EditorOrderFunction(
      {Key key, @required this.orderID, this.date, this.deadline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _media = MediaQuery.of(context).size;
    return Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: _media.height * 0.4,
          width: _media.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Order ID',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Date',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Deadline",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(orderID),
                  Text(date.toString()),
                  Text(deadline.toString())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      //accept and send notification to admin, delete from stack
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OrderPage()));
                    },
                    child: Text("Accept"),
                    color: Colors.green,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      //delete entry from stack
                      //send notification to admin
                    },
                    child: Text("Decline"),
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
