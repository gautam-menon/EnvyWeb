import 'package:flutter/material.dart';

class OnGoingOrders extends StatefulWidget {
  @override
  _OnGoingOrdersState createState() => _OnGoingOrdersState();
}

class _OnGoingOrdersState extends State<OnGoingOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("On going orders"),
        centerTitle: true,
      ),
      body: Container(child: Column(
        children: [
         Row(children: [
           Text("Gautam"),
           Text("Assigned to: "),
           Text("Order 1")
         ],)
        ],
      ),),
    );
  }
}
