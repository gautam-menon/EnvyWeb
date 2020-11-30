import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envyweb/Screens/Editor/ProfilePage.dart';
import 'package:envyweb/Services/FireStoreFunctions.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  void initState() {
    FireStoreFunctions().getStatus().then((data) {
      setState(() {
        status = data;
      });
    });
    super.initState();
  }

  Stream<QuerySnapshot> status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Status"),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
              child: StreamBuilder<QuerySnapshot>(
            stream: status,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new StatusTile(
                      content: document.data()['message'],
                      date: document.data()['time'],
                      editorId: document.data()['editorId']);
                }).toList(),
              );
            },
          )),
        ));
  }
}

class StatusTile extends StatelessWidget {
  final String content;
  final int date;
  final String editorId;

  const StatusTile({Key key, @required this.content, this.date, this.editorId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProfilePage(uid: editorId)));
            },
            child: Container(
              height: screen.height * 0.18,
              width: screen.width * 0.95,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    content ?? "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateTime.fromMillisecondsSinceEpoch(date).toString(),
                      style: TextStyle(fontSize: 15),
                    ),
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
