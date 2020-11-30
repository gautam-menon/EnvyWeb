import 'package:envyweb/Services/ApiFunctions%20-Admin.dart';
import 'package:flutter/material.dart';

class EditorList extends StatefulWidget {
  @override
  _EditorListState createState() => _EditorListState();
}

class _EditorListState extends State<EditorList> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Editors"), centerTitle: true),
      body: Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: ListView(
          children: <Widget>[
            Divider(),
            FutureBuilder(
                future: ApiFunctionsAdmin().getAllEditors(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? snapshot.data != false
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Plan',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Phone Number',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    width: screenWidth,
                                    height: screenheight * 0.9,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length > 10
                                          ? 10
                                          : snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return EditorTile(
                                          name: snapshot.data[index]['name'] ??
                                              "No name",
                                          tier: snapshot.data[index]['tier'] ??
                                              "No tier",
                                          phoneNo: int.parse(snapshot
                                                  .data[index]['phoneNo']) ??
                                              0,
                                        );
                                      },
                                    )),
                              ],
                            )
                          : Center(
                              child: Text("No Editors Found",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)))
                      : CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}

class EditorTile extends StatelessWidget {
  final String name;
  final String tier;
  final int phoneNo;
  const EditorTile({
    Key key,
    this.name,
    this.tier,
    this.phoneNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenheight / 9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Container(
            width: screenWidth / 3,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    child: Text(name.substring(0, 2) ?? ""),
                  ),
                  Text(name ?? ""),
                ]),
          ),
          Container(
            width: screenWidth / 3,
            child: Text(
              tier.toUpperCase(),
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            height: screenheight / 11,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tier == 'BASIC'
                  ? Colors.green
                  : tier == 'PREMIUM'
                      ? Colors.orange
                      : Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Container(
              child: Center(child: Text(phoneNo.toString() ?? "")),
              width: screenWidth / 4),
        ],
      ),
    );
  }
}
