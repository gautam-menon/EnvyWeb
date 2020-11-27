import 'package:envyweb/Services/ApiFunctions%20-Editor.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({Key key, this.uid}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Container(
          child: Center(
        child: FutureBuilder(
            future: ApiFunctionsEditors().getEditorDetails(widget.uid ?? "1"),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? snapshot.data != false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Editor",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.height * 0.1,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'),
                            ),
                            Divider(),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Name',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text('Email',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text('Phone Number',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text('Tier',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(snapshot.data['name'] ?? ""),
                                      Text(snapshot.data['email'] ?? ""),
                                      Text(
                                          snapshot.data['phoneNo'].toString() ??
                                              ""),
                                      Text(
                                          snapshot.data['tier'].toUpperCase() ??
                                              ""),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text("An error occuered.",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        )
                  : CircularProgressIndicator();
            }),
      )),
    );
  }
}
