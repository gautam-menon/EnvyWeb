import 'package:envyweb/Models/UserModel.dart';
import 'package:envyweb/Screens/Editor/AcceptedOrders.dart';
import 'package:envyweb/Services/ApiFunctions%20-Admin.dart';
import 'package:flutter/material.dart';

class AllOrders extends StatelessWidget {
  final UserModel editor;

  const AllOrders({Key key, @required this.editor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
            future: ApiFunctionsAdmin().getAllOrders(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Container(
                      height: _media.height * 0.7,
                      width: _media.width * 0.7,
                      child: Column(
                        children: [
                          snapshot.data != false
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  //print(snaps)
                                  itemBuilder: (context, index) {
                                    return AcceptedOrderTile(
                                      orderId: snapshot.data[index]['orderid'],
                                      deadline: snapshot.data[index]
                                          ['deadline'],
                                      date:
                                          1600000000000, //snapshot.data['startTime'],
                                      user: editor,
                                      userId: snapshot.data[index]['uid'],
                                    );
                                  },
                                )
                              : Center(
                                  child: Text("No Orders Found",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold))),
                        ],
                      ),
                    )
                  : CircularProgressIndicator();
            }),
      ),
    );
  }
}
