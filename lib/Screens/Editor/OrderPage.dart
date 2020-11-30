import 'dart:convert';
import 'dart:html';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:envyweb/Services/ApiFunctions%20-Editor.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:firebase/firebase.dart' as fb;

class OrderPage extends StatefulWidget {
  final String orderId;
  final String uid;
  const OrderPage({this.orderId, this.uid});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    var _media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Order Details'), centerTitle: true),
      body: Container(
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
                      int remainingTime = ((snapshot.data['deadline'] -
                                  DateTime.now().millisecondsSinceEpoch) /
                              3600000)
                          .round();
                      return snapshot.hasData
                          ? snapshot.data != false
                              ? SingleChildScrollView(
                                                              child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                        Visibility(
                                          visible: visible,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CircularProgressIndicator(),
                                              Text(
                                                "Uploading...",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
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
                                        Text(remainingTime.toString() +
                                            " hours left"),
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
                                              onPressed: () async {
                                                setState(() {
                                                  visible = true;
                                                });
                                                final path =
                                                    DateTime.now().toString();
                                                String imgUrl;
                                                await uploadImage(
                                                  onSelected: (file) async {
                                                    var query = fb
                                                        .storage()
                                                        .refFromURL(
                                                            'gs://envy-f1ba5.appspot.com/')
                                                        .child(path);
                                                    await query
                                                        .put(file)
                                                        .future
                                                        .then((_) async {
                                                      await _.ref
                                                          .getDownloadURL()
                                                          .then((value) =>
                                                              imgUrl = value
                                                                  .toString());
                                                      assert(imgUrl != null);
                                                      var response =
                                                          await ApiFunctionsEditors()
                                                              .submitOrder(
                                                                  imgUrl,
                                                                  widget
                                                                      .orderId,
                                                                  widget.uid);
                                                      if (response['status']) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) => Dialog(
                                                                child: Container(
                                                                    height: MediaQuery.of(context).size.height / 2,
                                                                    width: MediaQuery.of(context).size.width / 2,
                                                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                                                      Icon(
                                                                        Icons
                                                                            .done,
                                                                        size:
                                                                            70,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                      Text(response[
                                                                              'req'] ??
                                                                          "Image submitted Successfully!"),
                                                                      RaisedButton(
                                                                        child: Text(
                                                                            "Okay"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          setState(
                                                                              () {
                                                                            visible =
                                                                                false;
                                                                          });
                                                                        },
                                                                      )
                                                                    ]))));
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) => Dialog(
                                                                child: Container(
                                                                    height: MediaQuery.of(context).size.height / 2,
                                                                    width: MediaQuery.of(context).size.width / 2,
                                                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                                                      Icon(
                                                                        Icons
                                                                            .error,
                                                                        size:
                                                                            70,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      Text(response[
                                                                              'req'] ??
                                                                          "Account could not be created"),
                                                                      RaisedButton(
                                                                        child: Text(
                                                                            "Okay"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          setState(
                                                                              () {
                                                                            visible =
                                                                                false;
                                                                          });
                                                                        },
                                                                      )
                                                                    ]))));
                                                      }
                                                      print(response);
                                                    });
                                                  },
                                                );
                                              },
                                              child:
                                                  Text("Upload Edited Image"),
                                            ),
                                          ],
                                        )
                                      ]),
                              )
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
    );
  }

  uploadImage({@required Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }
}
