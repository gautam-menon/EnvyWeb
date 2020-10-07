import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Incoming Orders"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Order ID"),
                Text("Date of Ordering"),
                Text("Deadline")
              ],
            )
          ],
        ),
      ),
    );
  }
}
