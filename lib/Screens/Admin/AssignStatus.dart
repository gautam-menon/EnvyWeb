import 'package:flutter/material.dart';

import 'Dashboard.dart';

class AssignStatus extends StatelessWidget {
  final bool status;

  const AssignStatus({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return status
        ? Container(
            child: Column(
            children: [
              Icon(
                Icons.done,
                size: MediaQuery.of(context).size.height/2,
                color: Colors.green,
              ),
              RaisedButton(
                child: Text("Okay"),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => AdminPage()),
                    (Route<dynamic> route) => false),
              )
            ],
          ))
        : Container(
            child: Column(
              children: [
                Icon(
                  Icons.error,
                  size: MediaQuery.of(context).size.height/2,
                  color: Colors.red,
                ),
                RaisedButton(
                  child: Text("Okay"),
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => AdminPage()),
                      (Route<dynamic> route) => false),
                )
              ],
            ),
          );
  }
}
