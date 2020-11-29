import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:envyweb/Screens/Editor/SubmitPage.dart';
import 'package:envyweb/Services/ApiFunctions%20-Editor.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

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
    var _media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Order Details'), centerTitle: true),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: FutureBuilder(
                      future:
                          ApiFunctionsEditors().getOrderDetails(widget.orderId),
                      builder: (context, snapshot) {
                        List features =
                            snapshot.hasData && snapshot.data != false
                                ? json.decode(snapshot.data['features'])
                                : [];
                        return snapshot.hasData
                            ? snapshot.data != false
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                imageUrl: snapshot
                                                        .data['rawBase64'] ??
                                                    "https://wallpaperaccess.com/full/2109.jpg",
                                              ),
                                              height: _media.height * 0.5,
                                              width: _media.width * 0.3),
                                        ),
                                        Text("Tier",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Text(snapshot.data['tierId'] ?? "Tier"),
                                        Text("Date of ordering",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Text(snapshot.data['timestamp'] ??
                                            "Timestamp"),
                                        Text("Deadline",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Text(snapshot.data['endTime'] ?? "5"),
                                        Container(
                                            color: Colors.grey[100],
                                            height: _media.height * 0.15,
                                            width: _media.width * 0.3,
                                            child: Column(
                                              children: [
                                                Text("Features Ordered",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: features.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Center(
                                                        child: Text(
                                                            features[index]
                                                                ['title']));
                                                  },
                                                ),
                                              ],
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            RaisedButton(
                                              onPressed: () async {
                                                String imageUrl =
                                                    snapshot.data['rawBase64'];

                                                html.AnchorElement
                                                    anchorElement =
                                                    new html.AnchorElement(
                                                        href: imageUrl);
                                                anchorElement.download =
                                                    imageUrl;
                                                anchorElement.click();
                                              },
                                              child: Text("Download Image"),
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SubmitPage(
                                                                orderId: widget
                                                                    .orderId,
                                                                userId: snapshot
                                                                        .data[
                                                                    'uid'])));
                                              },
                                              child:
                                                  Text("Upload Edited Image"),
                                            ),
                                          ],
                                        )
                                      ])
                                : Center(
                                    child: Text(
                                    "Order details unavailable",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ))
                            : CircularProgressIndicator();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
