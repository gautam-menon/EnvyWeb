import 'dart:io';
import 'package:envyweb/Services/ApiFunctions%20-Editor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class SubmitPage extends StatefulWidget {
  final String userId;
  final String orderId;

  const SubmitPage({Key key, this.userId, this.orderId}) : super(key: key);
  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  Image image;
  File imageFile;
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit Image"),
      ),
      body: Container(
        height: screen.height,
        width: screen.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  Image fromPicker = await ImagePickerWeb.getImage(
                      outputType: ImageType.widget);
                  imageFile =
                      await ImagePickerWeb.getImage(outputType: ImageType.file);
                  if (fromPicker != null && imageFile!=null) {
                    setState(() {
                      image = fromPicker;
                    });
                  }
                },
                child: Container(
                  color: Colors.grey,
                  height: screen.height * 0.5,
                  width: screen.width * 0.4,
                  child: image != null
                      ? image
                      : Center(
                          child: Text(
                          'Click here to upload an image',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        image = null;
                      });
                    },
                    child: Text("Reselect Image"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      ApiFunctionsEditors().submitOrder(
                          imageFile, widget.orderId, widget.userId);
                    },
                    child: Text("Upload Image"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
