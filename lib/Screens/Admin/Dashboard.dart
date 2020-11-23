import 'package:cached_network_image/cached_network_image.dart';
import 'package:envyweb/Screens/Admin/Status.dart';
import 'package:envyweb/Screens/HomePage.dart';
import 'package:envyweb/Services/ApiFunctions%20-Admin.dart';
import 'package:envyweb/Services/Auth.dart';
import 'package:envyweb/Services/Widgets/DrawerItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AddAdmin.dart';
import 'AddEditor.dart';
import 'AssignStatus.dart';
import 'Editors -Admin.dart';

class AdminPage extends StatefulWidget {
  final String name;

  const AdminPage({Key key, this.name, String uid}) : super(key: key);
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Customize("Dashboard", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminPage()));
              }),
              // Customize("Pending Orders", () {      Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => OnGoingOrders()));}),
              Customize("Status", () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Status()));
              }),

              Customize("Editors", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditorList(
                              media: _media,
                            )));
              }),
              Customize("Add Editor", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEditor()));
              }),
              Customize("Add Admin", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddAdmin()));
              }),
              Customize("Log out", () async {
                await AuthService().logOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()),
                    (Route<dynamic> route) => false);
              }),
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
                        "Admin, " + widget.name.toString(),
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
                      buttons("Basic", 1),
                      buttons("Premium", 2),
                      buttons("Pro", 3)
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

  getOrderFunction(int tier) {
    ApiFunctionsAdmin adminClass = ApiFunctionsAdmin();

    switch (tier) {
      case 1:
        return adminClass.getBasicOrders();
        break;
      case 2:
        return adminClass.getPremiumOrders();
        break;
      case 3:
        return adminClass.getProOrders();
        break;
      default:
        return adminClass.getAllUnassignedOrders();
        break;
    }
  }

  Widget ordersWidget() {
    var _media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: getOrderFunction(tier),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: _media.width,
                    height: _media.height * 0.9,
                    child: snapshot.data != false
                        ? snapshot.data.length == 0
                            ? Center(
                                child: Text("No Orders Found",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length > 10
                                    ? 10
                                    : snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return OrderFunction(
                                    orderID: snapshot.data[index]['orderid'],
                                    status: snapshot.data[index]['isComplete'],
                                    date: int.parse(
                                        snapshot.data[index]['timestamp']),
                                    price: int.parse(
                                        snapshot.data[index]['timestamp']),
                                    tierId: int.parse(
                                        snapshot.data[index]['tierId']),
                                    imgUrl: snapshot.data[index]['rawBase64'],
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
    );
  }

  int tier = 1;
  Widget buttons(String text, int selectedTier) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.2,
      child: RaisedButton(
        color: Colors.white,
        child: Text(text),
        onPressed: selectedTier == tier
            ? null
            : () {
                setState(() {
                  tier = selectedTier;
                });
              },
      ),
    );
  }
}

class OrderFunction extends StatefulWidget {
  final String orderID;
  final String status;
  final int price;
  final int date;
  final int tierId;
  final String imgUrl;

  const OrderFunction(
      {Key key,
      @required this.orderID,
      this.status,
      this.price,
      this.date,
      this.tierId,
      this.imgUrl})
      : super(key: key);

  @override
  _OrderFunctionState createState() => _OrderFunctionState();
}

class _OrderFunctionState extends State<OrderFunction> {
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
              SizedBox(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageUrl: widget.imgUrl ??
                        "https://wallpaperaccess.com/full/2109.jpg",
                  ),
                  height: _media.height * 0.2,
                  width: _media.width * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(widget.status),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Payment',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(widget.price.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(DateTime.fromMillisecondsSinceEpoch(widget.date)
                          .toString()),
                    ],
                  ),
                ],
              ),
              RaisedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: FutureBuilder(
                                future: getEditorFunction(widget.tierId),
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? Container(
                                          height: _media.height * 0.7,
                                          width: _media.width * 0.7,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text("Assign To Editor",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25)),
                                                  IconButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    color: Colors.red,
                                                    icon: Icon(Icons.cancel),
                                                  )
                                                ],
                                              ),
                                              Divider(),
                                              snapshot.data != false
                                                  ? ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          snapshot.data.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return editors(
                                                            snapshot.data[index]
                                                                ['name'],
                                                            snapshot.data[index]
                                                                ['uid'],
                                                            widget.orderID,
                                                            snapshot.data[index]
                                                                ['tier'],
                                                            snapshot.data[index]
                                                                ['email'],
                                                            context);
                                                      },
                                                    )
                                                  : Center(
                                                      child: Text(
                                                          "No Editors Found",
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                            ],
                                          ),
                                        )
                                      : CircularProgressIndicator();
                                }),
                          ));
                },
                child: Text("Assign"),
                color: Colors.amber,
              ),
            ],
          ),
        ));
  }

  getEditorFunction(int tier) {
    ApiFunctionsAdmin adminClass = ApiFunctionsAdmin();
    switch (tier) {
      case 1:
        return adminClass.getAllBasicEditors();
        break;
      case 2:
        return adminClass.getAllPremiumEditors();
        break;
      case 3:
        return adminClass.getAllProEditors();
        break;
      default:
        return adminClass.getAllEditors();
        break;
    }
  }

  String getTier(int tier) {
    switch (tier) {
      case 1:
        return "Basic";
        break;
      case 2:
        return "Premium";
        break;
      case 3:
        return "Pro";
        break;
      default:
        return "Tier not found";
        break;
    }
  }

  Widget editors(String name, String id, String orderid, String tier,
      String email, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(border: Border.all()),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(children: [
              Text(name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Text(email),
              Text(tier)
            ]),
            RaisedButton(
              onPressed: () async {
                bool response =
                    await ApiFunctionsAdmin().assignToEditor(id, orderid, tier);
                if (response == true) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AssignStatus(status: response)),
                      (Route<dynamic> route) => false);
                }
              },
              child: Text("Assign"),
              color: Colors.amber,
            ),
          ])),
    );
  }
}
