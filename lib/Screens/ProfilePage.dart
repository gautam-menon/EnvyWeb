import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            CircleAvatar(
                child: CachedNetworkImage(
              imageUrl:
                  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg",
            )),
            Text("Name"),
            Text("Date joined"),
          ],
        ),
      ),
    );
  }
}
