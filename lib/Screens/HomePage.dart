import 'package:envyweb/Screens/LoginPage.dart';
import 'package:flutter/material.dart';

import 'Admin/Dashboard.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          // color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                     "Envy Editor",
                  style: TextStyle(
                    fontSize: 30,
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Discover',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: screenSize.width / 20),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Contact Us',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminPage()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(children: [
        SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Image.network(
              "https://wallpaperaccess.com/full/2109.jpg",
              fit: BoxFit.cover,
            )),


  
      ]),
    );
  }
}
