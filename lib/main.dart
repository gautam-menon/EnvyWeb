import 'package:flutter/material.dart';

import 'Screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Envy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
                primarySwatch: Colors.blueGrey,
                backgroundColor: Colors.white,
                cardColor: Colors.blueGrey[50],
                primaryTextTheme: TextTheme(
                  button: TextStyle(
                    color: Colors.blueGrey,
                    decorationColor: Colors.blueGrey[300],
                  ),
                  subtitle1: TextStyle(
                    color: Colors.black,
                  ),
                ),
                bottomAppBarColor: Colors.blueGrey[900],
                iconTheme: IconThemeData(color: Colors.blueGrey),
                brightness: Brightness.light,
              ),
      home: HomePage(title: 'Envy Backend '),
    );
  }
}
