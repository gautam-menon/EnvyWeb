import 'dart:html';
import 'dart:typed_data';
import 'package:envyweb/Services/ApiFunctions%20-Editor.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';

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
        title: Text("Submit Imge"),
      ),
      body: Container(
        height: screen.height,
        width: screen.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // InkWell(
              //   onTap: () async {
              // Image fromPicker =
              //     await ImagePickerWeb.getImage(outputType: ImageType.widget);
              //MediaInfo mediaData = await ImagePickerWeb.getImageInfo;

              // if (mediaData != null) {
              //   setState(() {
              //     //image = fromPicker;
              //     bytes = mediaData.data;
              //   });
              // }
              //  },
              // child: Container(
              //   color: Colors.grey,
              //   height: screen.height * 0.5,
              //   width: screen.width * 0.4,
              //   child: bytes != null
              //       ? Image.memory(bytes)
              //       : Center(
              //           child: Text(
              //           'Click here to upload an image',
              //           style: TextStyle(
              //               fontSize: 20, fontWeight: FontWeight.bold),
              //         )),
              // ),
              //),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // RaisedButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       bytes = null;
                  //     });
                  //   },
                  //   child: Text("Reselect Image"),
                  // ),
                  RaisedButton(
                    onPressed: () async {
                      final path = DateTime.now().toString();
                      String imgUrl;
                      await uploadImage(
                        onSelected: (file) async {
                          var query = fb
                              .storage()
                              .refFromURL('gs://envy-f1ba5.appspot.com/')
                              .child(path);
                          await query.put(file).future.then((_) async {
                            await _.ref
                                .getDownloadURL()
                                .then((value) => imgUrl = value.toString());
                            assert(imgUrl != null);
                            var response = await ApiFunctionsEditors()
                                .submitOrder(
                                    imgUrl, widget.orderId, widget.userId);
                            if (response['status']) {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.done,
                                                  size: 70,
                                                  color: Colors.green,
                                                ),
                                                Text(response['req'] ??
                                                    "Image submitted Successfully!"),
                                                RaisedButton(
                                                  child: Text("Okay"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ]))));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.error,
                                                  size: 70,
                                                  color: Colors.red,
                                                ),
                                                Text(response['req'] ??
                                                    "Account could not be created"),
                                                RaisedButton(
                                                  child: Text("Okay"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ]))));
                            }
                            print(response);
                          });
                        },
                      );
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
