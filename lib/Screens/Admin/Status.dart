import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Status"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StatusTile(
                  content:
                      "Verify definition is - to establish the truth, accuracy, or reality of. How to use verify in a sentence. Synonym Discussion of verify",
                  date: 2453,
                ),
                StatusTile(
                  content:
                      "Verify definition is - to establish the truth, accuracy, or reality of. How to use verify in a sentence. Synonym Discussion of verify",
                  date: 2453,
                ),
                StatusTile(
                  content:
                      "Verify definition is - to establish the truth, accuracy, or reality of. How to use verify in a sentence. Synonym Discussion of verify",
                  date: 2453,
                ),
                StatusTile(
                  content:
                      "Verify definition is - to establish the truth, accuracy, or reality of. How to use verify in a sentence. Synonym Discussion of verify",
                  date: 2453,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatusTile extends StatelessWidget {
  final String content;
  final int date;

  const StatusTile({Key key, @required this.content, this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: screen.height * 0.2,
            width: screen.width * 0.95,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  content,
                  style: TextStyle(fontSize: 22),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    date.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
