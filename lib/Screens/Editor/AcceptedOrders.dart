import 'package:envyweb/Models/UserModel.dart';
import 'package:envyweb/Screens/Editor/ChatPage.dart';
import 'package:envyweb/Services/ApiFunctions%20-Editor.dart';
import 'package:flutter/material.dart';

class AcceptedOrders extends StatefulWidget {
  final UserModel user;

  const AcceptedOrders({Key key, @required this.user}) : super(key: key);
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
                        .getconfirmedWorkOrders(widget.user.uid),
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
                                              ['orderid'],
                                          date: snapshot.data[index]
                                              ['startTime'],
                                          deadline: snapshot.data[index]
                                              ['deadline'],
                                          user: widget.user,
                                          userId: snapshot.data[index]['uid'],
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
  final UserModel user;
  final String userId;

  const AcceptedOrderTile(
      {Key key,
      this.orderId,
      this.date,
      this.deadline,
      this.user,
      @required this.userId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    int remainingTime =
        ((deadline - DateTime.now().millisecondsSinceEpoch) / 3600000).round();
    var screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height / 6,
      width: screenSize.width,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Text('Deadline',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              Text(remainingTime.toString() + " hours left"),
            ]),
            RaisedButton(
              child: Text('Proceed'),
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderChat(
                            userId: userId,
                            orderid: orderId ?? "1",
                            user: user ?? "1")));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => OrderPage(
                //             orderId: orderId ?? "1", uid: uid ?? "1")));
              },
            )
          ],
        ),
      ),
    );
  }
}
