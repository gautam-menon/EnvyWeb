import 'package:envyweb/Services/ApiFunctions%20-Editor.dart';
import 'package:flutter/material.dart';

import 'OrderPage.dart';

class AcceptedOrders extends StatefulWidget {
  final String uid;

  const AcceptedOrders({Key key, this.uid}) : super(key: key);
  @override
  _AcceptedOrdersState createState() => _AcceptedOrdersState();
}

class _AcceptedOrdersState extends State<AcceptedOrders> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Accepted Orders"),
          centerTitle: true,
        ),
        body: Container(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: [
                FutureBuilder(
                    future: ApiFunctionsEditors()
                        .getconfirmedWorkOrders(widget.uid),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Container(
                              decoration: BoxDecoration(border: Border.all()),
                              width: screenSize.width,
                              height: screenSize.height * 0.9,
                              child: snapshot.data != false
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length > 10
                                          ? 10
                                          : snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return AcceptedOrderTile(
                                          orderId: snapshot.data[index]
                                              ['orderID'],
                                          date: snapshot.data[index]
                                              ['startTime'],
                                          deadline: snapshot.data[index]
                                              ['endTime'],
                                          //uid: snapshot.data['editorID']
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text("No Orders Found",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold))),
                            )
                          : CircularProgressIndicator();
                    }),
              ],
            )));
  }
}

class AcceptedOrderTile extends StatelessWidget {
  final String orderId;
  final int date;
  final int deadline;
  final String uid;

  const AcceptedOrderTile(
      {Key key, this.orderId, this.date, this.deadline, this.uid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderPage(orderId: orderId)));
      },
      child: Container(
        height: screenSize.height / 5,
        width: screenSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Text('Order ID', style: TextStyle(color: Colors.grey)),
              Text(orderId),
            ]),
            Column(children: [
              Text('Date', style: TextStyle(color: Colors.grey)),
              Text(date.toString()),
            ]),
            Column(children: [
              Text('Deadline', style: TextStyle(color: Colors.grey)),
              Text(deadline.toString()),
            ]),
            IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderPage(
                              orderId: orderId,
                              uid: uid,
                            )));
              },
            )
          ],
        ),
      ),
    );
  }
}
