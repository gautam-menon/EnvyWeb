import 'package:envyweb/Services/ApiFunctions%20-Admin.dart';
import 'package:flutter/material.dart';


class EditorList extends StatefulWidget {
  const EditorList({
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  _EditorListState createState() => _EditorListState();
}

class _EditorListState extends State<EditorList> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: widget._media.height,
        width: widget._media.width * 0.37,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(width: 2),
                          Text(
                            'Name',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Tier',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Priority',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Budget',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      FutureBuilder(
          future: ApiFunctionsAdmin().getAllEditors(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: widget._media.width,
                    height: widget._media.height * 0.9,
                    child: snapshot.data != false
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length > 10
                                ? 10
                                : snapshot.data.length,
                            itemBuilder: (context, index) {
                              return EditorTile(
                                name: snapshot.data[index]['name'],
                                tier: snapshot.data[index]['isComplete'],
                                phoneNo: int.parse(
                                    snapshot.data[index]['phoneNo']),
                          
                              );
                            },
                          )
                        : Center(
                            child: Text("No Editors Found",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                  )
                : CircularProgressIndicator();
          }),
                      
                    ],
                  ),
                ),
              ],
            ),
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
    Key key, this.name, this.tier, this.phoneNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                child: Text(name.substring(0, 2)),
              ),
              SizedBox(
                width: 10,
              ),
              Text(name),
            ],
          ),
          Text(
            tier,
            textAlign: TextAlign.justify,
          ),
          Container(
            child: Text(
              tier == 'basic'
                  ? 'Low'
                  : tier == 'premium'
                      ? 'Medium'
                      : 'High',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            height: 30,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Text(phoneNo.toString()),
        ],
      ),
    );
  }
}
