import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image.network("src"),
            Text(
              "Instructions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Features requested"),
            Text("Date of Ordering"),
            Text("Deadline"),
            RaisedButton(
              onPressed: () {},
              child: Text("Download Image"),
            )
          ],
        ),
      ),
    );
  }
}
