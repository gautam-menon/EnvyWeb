import 'package:cached_network_image/cached_network_image.dart';
import 'package:envyweb/Screens/Editor/SubmitPage.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final String orderId;
  final String uid;
  const OrderPage({this.orderId, this.uid});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Order Details",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: screen.height * 0.5,
                  width: screen.width * 0.4,
                  child: CachedNetworkImage(
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg"),
                ),
                Text(
                  "Features requested",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Features",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Date of Ordering",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Date",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Deadline",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Deadline",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Download Image"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubmitPage()));
                      },
                      child: Text("Upload Edited Image"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
