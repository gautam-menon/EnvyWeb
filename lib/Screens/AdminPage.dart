import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Customize("Dashboard", () {}),
              Customize("Profile", () {}),
              Customize("Editors", () {}),
              Customize("Log out", () {}),
            ],
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Admin",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Incoming Orders",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  ordersWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ordersWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            OrderFunction(
              orderID: "ncjdcn",
              status: "Pending",
              price: 50,
              date: 185030,
            ),
            OrderFunction(
              orderID: "ncjdcn",
              status: "Pending",
              price: 50,
              date: 185030,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderFunction extends StatelessWidget {
  final String orderID;
  final String status;
  final int price;
  final int date;

  const OrderFunction(
      {Key key, @required this.orderID, this.status, this.price, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Order ID: " + orderID),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Status: " + status),
              Text("Payment: Rs." + price.toString()),
              Text("Date: " + date.toString())
            ],
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Assign"),
            color: Colors.amber,
          ),
          Container(
            color: Colors.black,
            height: 1,
          )
        ],
      ),
    );
  }
}

class Customize extends StatelessWidget {
  Customize(this.text, this.onTap);
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
