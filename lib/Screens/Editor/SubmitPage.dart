import 'dart:html';
import 'dart:typed_data';
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
  Uint8List bytes;

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
                  // Image fromPicker =
                  //     await ImagePickerWeb.getImage(outputType: ImageType.widget);
                  MediaInfo mediaData = await ImagePickerWeb.getImageInfo;

                  if (mediaData != null) {
                    setState(() {
                      //image = fromPicker;
                      bytes = mediaData.data;
                    });
                  }
                },
                child: Container(
                  color: Colors.grey,
                  height: screen.height * 0.5,
                  width: screen.width * 0.4,
                  child: bytes != null
                      ? Image.memory(bytes)
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
                        bytes = null;
                      });
                    },
                    child: Text("Reselect Image"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      // bool response = await ApiFunctionsEditors()
                      //     .submitOrder(bytes, widget.orderId, widget.userId);
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

  void uploadImage({@required Function(File file) onSelected}) {
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

  onSelected(File file) async {
    // bool x = await ApiFunctionsEditors().submitOrder(image, orderId, userId);
  }
}
