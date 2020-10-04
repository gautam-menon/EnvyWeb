import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Editors -Admin.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    int tier = 1;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Customize("Dashboard", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminPage(
                           
                            )));
              }),
              Customize("Pending Orders", () {}),
              Customize("Completed Orders", () {}),
              Customize("Profile", () {}),
              Customize("Editors", () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditorList(
                                media: _media,
                            )));
              }),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Admin, 'name'",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Incoming Orders",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttons(
                          "Basic",
                          tier == 1
                              ? null
                              : () {
                                  setState(() {
                                    tier = 1;
                                  });
                                }),
                      buttons(
                          "Premium",
                          tier == 2
                              ? null
                              : () {
                                  setState(() {
                                    tier = 1;
                                  });
                                }),
                      buttons(
                          "Pro",
                          tier == 3
                              ? null
                              : () {
                                  setState(() {
                                    tier = 1;
                                  });
                                })
                    ],
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

  Widget buttons(String text, function) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.2,
      child: RaisedButton(
        color: Colors.white,
        child: Text(text),
        onPressed: () => function,
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
    var _media = MediaQuery.of(context).size;
    return Material(
        elevation: 10,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: _media.height * 0.4,
          width: _media.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Order ID',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Status',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Payment',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Date',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(orderID),
                  Text(status),
                  Text(price.toString()),
                  Text(date.toString())
                ],
              ),
              FlatButton(
                onPressed: () {},
                child: Text("Assign"),
                color: Colors.amber,
              ),
            ],
          ),
        ));
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
