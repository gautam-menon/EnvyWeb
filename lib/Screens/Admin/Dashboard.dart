import 'package:envyweb/Screens/Admin/Status.dart';
import 'package:envyweb/Screens/HomePage.dart';
import 'package:envyweb/Services/Auth.dart';
import 'package:envyweb/Services/Widgets/DrawerItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Editors -Admin.dart';

class AdminPage extends StatefulWidget {
  final name;

  const AdminPage({Key key, this.name}) : super(key: key);
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
                  isLoading ? CircularProgressIndicator() : ordersWidget(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(orderID),
                  Text(status),
                  Text(price.toString()),
                  Text(date.toString())
                ],
              ),
              RaisedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Container(
                        height: _media.height * 0.7,
                        width: _media.width * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )),
                              Text(
                                "Assign to Editors",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              Divider(),
                              editors("Editors 1"),
                              editors("Editors 2"),
                              editors("Editors 3"),
                            ],
                          ),
                        ),
                        // child: FutureBuilder(
                        //     future: ApiFunctions().getEditors(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        //         return Container(
                        //           child: Text(snapshot.data.toString()),
                        //         );
                        //       } else {
                        //         return CupertinoActivityIndicator();
                        //       }
                        //     }),
                      ),
                    ),
                  );
                },
                child: Text("Assign"),
                color: Colors.amber,
              ),
            ],
          ),
        ));
  }

  Widget editors(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(name),
        RaisedButton(
          onPressed: () {},
          child: Text("Assign"),
          color: Colors.amber,
        )
      ],
    );
  }
}
